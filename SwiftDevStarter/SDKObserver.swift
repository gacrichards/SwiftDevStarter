//
//  SDKObserver.swift
//  SwiftDevStarter
//
//  Created by Cole Richards on 6/7/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

import CoreFoundation

class SDKObserver: NSObject, ROXDeviceHookDelegate {
    
    var eventHistory = [ROXEventInfo]()
    var eventHistoryUpdateResponders = [EventHistoryUpdateResponder]()
    
    override init(){
        super.init()
        
        ROXIMITYEngine.setDeviceHookDelegate(self)
    }
    
    func addNewEventHistoryResponder(responder:EventHistoryUpdateResponder){
        eventHistoryUpdateResponders.append(responder)
        updateResponders()
    }
    
    
    func didReceiveROXIMITYEvent(event: ROXEventInfo!) {
        eventHistory.append(event)
        updateResponders()
    }
    
    func updateResponders(){
        eventHistory.sortInPlace({$0.getTimestamp() > $1.getTimestamp()})
        eventHistoryUpdateResponders.forEach({$0.didUpdateWithNewEvent()})
    }

}


//Extending the ROXEventInfo Object to create some convenience outputs for my goal of outputing descriptions of the events
extension ROXEventInfo{
    
    
    func isActionDriven()->Bool{
        //Action driven events will generally have a name associated with the action, where signal driven events will have annonymous action names
        let action = self.getROXIMITYAction()
        if let _ = action.getName(){
            return true
        }
        return false
    }
    
    func isSignalDriven()->Bool{
        //Signal driven events are those that are not action driven
        return !isActionDriven()
    }
    
    //This will give me a top level description of the action that has taken place
    func getEventDescription()->String{
        if isActionDriven(){
           return createActionDrivenDescription()
        }else{
           return createSignalDrivenDescription()
        }
    }
    
    //This will yeild my first level detail description
    func getEventDetailDescription1()->String{
        if isActionDriven(){
            return createActionDrivenDetail1()
        }else{
            return createSignalDrivenDetail1()
        }
    }
    
    //This will yeild my second level detail description
    func getEventDetailDescription2()->String{
        if isActionDriven(){
            return createActionDrivenDetail2()
        }else{
            return createSignalDrivenDetail2()
        }
    }
    
    //This will give a formatted date from the event timestamp
    func getFormattedDateString()->String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .MediumStyle
        
        let eventDate = NSDate.init(timeIntervalSince1970: self.getTimestamp())
        
        return formatter.stringFromDate(eventDate)
    }
    
    //This will give a color label for events
    func getEventColor()->UIColor{
        if isActionDriven(){
            return getActionColor()
        }else{
            return getSignalColor()
        }
    }
    
    private func getActionColor()->UIColor{
        let action = self.getROXIMITYAction()
        
        switch action.getPresentationType() {
        case ROXActionPresentationType.PlaceVerified:
            return ROXIMITYEventColors.cyanBlue()
        default:
            return ROXIMITYEventColors.mediumYellow()
        }
    }
    
    private func getSignalColor()->UIColor{
        let signal = self.getROXIMITYSignal()
        switch signal.getSignalType() {
        case .Beacon:
            return ROXIMITYEventColors.orange()
        case .Geofence:
            return ROXIMITYEventColors.red()
        case .WiFi:
            return ROXIMITYEventColors.darkBlue()
        case .Place:
            return ROXIMITYEventColors.cyanBlue()
        default:
            return UIColor.lightGrayColor()
        }
        
    }
    
    private func createActionDrivenDetail1()->String{
        let action = self.getROXIMITYAction()
        return "ACTION: " + action.getName()
    }
    
    private func createSignalDrivenDetail1()->String{
        let signal = self.getROXIMITYSignal()
        return "SIGNAL: "+signal.getSignalName()
    }
    
    private func createActionDrivenDetail2()->String{
        
        let signal = self.getROXIMITYSignal()
        let signalTypeString = signalEventTypeString(signal)
        let signalName = signal.getSignalName() ?? ""
        return "TRIGGER: "+signalTypeString+" - "+signalName

    }
    
    private func createSignalDrivenDetail2()->String{
        let signal = self.getROXIMITYSignal()
        let signalTags = signal.getSignalTags()
        if signalTags.count > 0{
            return "TAGS: "+signalTags.map({"\($0)"}).joinWithSeparator(", ")
        }
        return ""
    }
    
    private func createActionDrivenDescription()->String{
        let action = self.getROXIMITYAction()
        let eventType = actionEventTypeString(action)
        let eventPresentation = actionPresentationTypeString(action)
        return eventPresentation+" "+eventType
    }
    
    private func createSignalDrivenDescription()->String{
        let signal = self.getROXIMITYSignal()
        let action = self.getROXIMITYAction()
        let signalType = signalEventTypeString(signal)
        let signalAction = actionEventTypeString(action)
        return signalType+" "+signalAction
    }
    
    private func actionEventTypeString(action: ROXIMITYAction)->String{
        switch action.getEventType() {
        case ROXSignalEventType.Entry:
            return "Entry"
        case ROXSignalEventType.Exit:
            return "Exit"
        case ROXSignalEventType.Proximity:
            return "Proximity"
        case ROXSignalEventType.Place:
            return "Verification"
        default:
            return ""
        }
    }
    
    private func actionPresentationTypeString(action: ROXIMITYAction)->String{
        switch action.getPresentationType() {
        case ROXActionPresentationType.Notification:
            return "Notification"
        case ROXActionPresentationType.Request:
            return "Request"
        case ROXActionPresentationType.Webview:
            return "Webview"
        case ROXActionPresentationType.WebhookPosted:
            return "Webhook"
        case ROXActionPresentationType.PlaceVerified:
            return "Place"
        default:
            return ""
        }
    }
    
    private func signalEventTypeString(signal: ROXIMITYSignal)->String{
        switch signal.getSignalType() {
        case ROXSignalOriginType.Beacon:
            return "Beacon"
        case ROXSignalOriginType.Geofence:
            return "Geofence"
        case ROXSignalOriginType.Gps:
            return "User Location"
        case ROXSignalOriginType.Place:
            return "Place"
        case ROXSignalOriginType.WiFi:
            return "WiFi"
        default:
            return ""
        }
    }
}

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
    
    func addNewEventHistoryResponder(_ responder:EventHistoryUpdateResponder){
        eventHistoryUpdateResponders.append(responder)
        updateResponders()
    }
    
    
    func didReceiveROXIMITYEvent(_ event: ROXEventInfo!) {
        if event.hasDeviceSegment() {event.printDeviceSegmentDictionary()}
        if event.isPlaceVerification(){ event.printPlaceProperties() }
        if event.isWiFiSignalEvent(){return}
        eventHistory.append(event)
        updateResponders()
    }
    
    func updateResponders(){
        eventHistory.sort(by: {$0.getTimestamp() > $1.getTimestamp()})
        eventHistoryUpdateResponders.forEach({$0.didUpdateWithNewEvent()})
    }

}


//Extending the ROXEventInfo Object to create some convenience outputs for my goal of outputing descriptions of the events
extension ROXEventInfo{
    
    
    func isActionDriven()->Bool{
        //Action driven events will generally have a name associated with the action, where signal driven events will have annonymous action names
        let action = self.getROXIMITYAction()!
        if let _ = action.getName(){
            return true
        }
        return false
    }
    
    func isSignalDriven()->Bool{
        //Signal driven events are those that are not action driven
        return !isActionDriven()
    }
    
    func isPlaceVerification()->Bool{
        let action = self.getROXIMITYAction()!
        return action.getEventType() == .place
    }
    
    func printPlaceProperties(){
        let action = self.getROXIMITYAction()!
        let properties = action.getProperties()
        print("Place Properties: \(properties ?? [AnyHashable : Any]())")
    }
    
    func hasDeviceSegment()->Bool{
        let deviceSegmentObj = self.getROXIMITYDeviceSegment()
        return deviceSegmentObj?.getDictionary() != nil
    }
    
    func printDeviceSegmentDictionary(){
        let deviceSegmentObj = self.getROXIMITYDeviceSegment()
        let segmentDesc = deviceSegmentObj?.getDictionary()
        guard(segmentDesc != nil)else{return}
        print("Device Segment info: \(segmentDesc!)")
    }
    
    func isWiFiSignalEvent()->Bool{
        let action = self.getROXIMITYAction()
        let signal = self.getROXIMITYSignal()
        return action?.getPresentationType() == .none && signal?.getType() == .wiFi
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
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        let eventDate = Date.init(timeIntervalSince1970: self.getTimestamp())
        
        return formatter.string(from: eventDate)
    }
    
    //This will give a color label for events
    func getEventColor()->UIColor{
        if isActionDriven(){
            return getActionColor()
        }else{
            return getSignalColor()
        }
    }
    
    fileprivate func getActionColor()->UIColor{
        let action = self.getROXIMITYAction()!
        
        switch action.getPresentationType() {
        case ROXActionPresentationType.placeVerified:
            return ROXIMITYEventColors.cyanBlue()
        default:
            return ROXIMITYEventColors.mediumYellow()
        }
    }
    
    fileprivate func getSignalColor()->UIColor{
        let signal = self.getROXIMITYSignal()!
        switch signal.getType() {
        case .beacon:
            return ROXIMITYEventColors.orange()
        case .geofence:
            return ROXIMITYEventColors.red()
        case .wiFi:
            return ROXIMITYEventColors.darkBlue()
        case .place:
            return ROXIMITYEventColors.cyanBlue()
        default:
            return UIColor.lightGray
        }
        
    }
    
    fileprivate func createActionDrivenDetail1()->String{
        let action = self.getROXIMITYAction()!
        return "ACTION: " + (action.getName() ?? "")
    }
    
    fileprivate func createSignalDrivenDetail1()->String{
        let signal = self.getROXIMITYSignal()!
        return "SIGNAL: " + signal.getName()
    }
    
    fileprivate func createActionDrivenDetail2()->String{
        
        let signal = self.getROXIMITYSignal()!
        let signalTypeString = signalEventTypeString(signal)
        let signalName = signal.getName() ?? ""
        return "TRIGGER: "+signalTypeString+" - "+signalName

    }
    
    fileprivate func createSignalDrivenDetail2()->String{
        let signal = self.getROXIMITYSignal()!
        let signalTags = signal.getTags()!
        if signalTags.count > 0{
            return "TAGS: "+signalTags.map({"\($0)"}).joined(separator: ", ")
        }
        return ""
    }
    
    fileprivate func createActionDrivenDescription()->String{
        let action = self.getROXIMITYAction()!
        let eventType = actionEventTypeString(action)
        let eventPresentation = actionPresentationTypeString(action)
        return eventPresentation+" "+eventType
    }
    
    fileprivate func createSignalDrivenDescription()->String{
        let signal = self.getROXIMITYSignal()!
        let action = self.getROXIMITYAction()!
        let signalType = signalEventTypeString(signal)
        let signalAction = actionEventTypeString(action)
        return signalType+" "+signalAction
    }
    
    fileprivate func actionEventTypeString(_ action: ROXIMITYAction)->String{
        switch action.getEventType() {
        case ROXSignalEventType.entry:
            return "Entry"
        case ROXSignalEventType.exit:
            return "Exit"
        case ROXSignalEventType.proximity:
            return "Proximity"
        case ROXSignalEventType.place:
            return "Verification"
        default:
            return ""
        }
    }
    
    fileprivate func actionPresentationTypeString(_ action: ROXIMITYAction)->String{
        switch action.getPresentationType() {
        case ROXActionPresentationType.notification:
            return "Notification"
        case ROXActionPresentationType.request:
            return "Request"
        case ROXActionPresentationType.webview:
            return "Webview"
        case ROXActionPresentationType.webhookPosted:
            return "Webhook"
        case ROXActionPresentationType.placeVerified:
            return "Place"
        default:
            return ""
        }
    }
    
    fileprivate func signalEventTypeString(_ signal: ROXIMITYSignal)->String{
        switch signal.getType() {
        case ROXSignalOriginType.beacon:
            return "Beacon"
        case ROXSignalOriginType.geofence:
            return "Geofence"
        case ROXSignalOriginType.gps:
            return "User Location"
        case ROXSignalOriginType.place:
            return "Place"
        case ROXSignalOriginType.wiFi:
            return "WiFi"
        default:
            return ""
        }
    }
}

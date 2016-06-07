//
//  SDKObserver.swift
//  SwiftDevStarter
//
//  Created by Cole Richards on 6/7/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

import CoreFoundation

class SDKObserver: NSObject, ROXDeviceHookDelegate {
    
    override init(){
        super.init()
        
        ROXIMITYEngine.setDeviceHookDelegate(self)
    }
    
    
    func didReceiveROXIMITYEvent(event: ROXEventInfo!) {
        let signal = event.getROXIMITYSignal()
        let action = event.getROXIMITYAction()
        
        if let signalName = signal.getSignalName(){
            print(signalName)
        }
        if let actionName = action.getName(){
            print(actionName)
        }
        
    }

}

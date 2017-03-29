//
//  AppDelegate.swift
//  SwiftDevStarter
//
//  Created by Cole Richards on 6/7/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ROXIMITYEngineDelegate {

    var window: UIWindow?
    var roxEventListener = SDKObserver.init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var engineOptions = [String:Any]();
        engineOptions[kROXEngineOptionsUserTargetingLimited] = false
        engineOptions[kROXEngineOptionsMuteBluetoothOffAlert] = false
        engineOptions[kROXEngineOptionsMuteLocationPermissionAlert] = false
        engineOptions[kROXEngineOptionsMuteNotificationPermissionAlert] = true
        engineOptions[kROXEngineOptionsMuteRequestAlerts] = false
        engineOptions[kROXEngineOptionsReservedBeaconRegions] = 0
        engineOptions[kROXEngineOptionsReservedGeofenceRegions] = 0
        engineOptions[kROXEngineOptionsStartLocationDeactivated] = false
        
        ROXIMITYEngine.start(launchOptions: launchOptions, engineOptions: engineOptions, applicationId: "YOUR-APP-ID-HERE", andEngineDelegate: self)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        ROXIMITYEngine.resignActive()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this
//        method is called instead of applicationWillTerminate: when the user quits.
        ROXIMITYEngine.background()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        ROXIMITYEngine.foreground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        ROXIMITYEngine.active()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        ROXIMITYEngine.terminate()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        ROXIMITYEngine.didFailToRegister(forRemoteNotifications: error)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        ROXIMITYEngine.didRegister(forRemoteNotifications: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let roximityNotification = ROXIMITYEngine.didReceiveRemoteNotification(application, userInfo: userInfo, fetchCompletionHandler: completionHandler)
        
        if roximityNotification{
            print("ROXIMITY Notification received and processed!")
        }else{
            //Handle remote fetch here
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        let roximityNotification = ROXIMITYEngine.didReceiveRemoteNotification(application, userInfo: userInfo)
        
        if roximityNotification{
            print("ROXIMITY Notification received and processed!")
        }else{
            //Handle remote fetch here
        }
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        let roximityNotification = ROXIMITYEngine.didReceiveLocalNotification(application, notification: notification)
        
        if roximityNotification{
            print("ROXIMITY Notification received and processed!")
        }else{
            //Handle remote fetch here
        }
    }
    
    


}


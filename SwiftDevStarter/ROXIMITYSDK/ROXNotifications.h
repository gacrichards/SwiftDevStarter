//
//  ROXIMITYNotifications.h
//  ROXIMITYlib
//
//  Created by Danny Pier on 9/18/13.
//  Copyright (c) 2013 ROXIMITY. All rights reserved.
//

/**
 @brief The ROXIMITYNotifications class
 */
#import <Foundation/Foundation.h>

@interface ROXNotifications : NSObject

#pragma mark - Engine Options

extern NSString * const kROXEngineOptionsReservedRegions;
extern NSString * const kROXEngineOptionsMuteBluetoothOffAlert;
extern NSString * const kROXEngineOptionsMuteRequestAlerts;
extern NSString * const kROXEngineOptionsMuteLocationPermissionAlert;
extern NSString * const kROXEngineOptionsMuteNotificationPermissionAlert;
extern NSString * const kROXEngineOptionsStartLocationDeactivated;
extern NSString * const kROXEngineOptionsDebugLogging;
extern NSString * const kROXEngineOptionsVerboseLogging;
extern NSString * const kROXEngineOptionsUserTargetingLimited;

#pragma mark - Notification Observer Constants

extern NSString * const kROXStateNotification;
extern NSString * const kROXRoximityLocalNotification;
extern NSString * const kROXRoximityPushNotification;
extern NSString * const kROXRoximityActionNotification;
extern NSString * const kROXRoximityTriggerNotification;
extern NSString * const kROXBeaconRangeUpdated;
extern NSString * const kROXMessageFired;
extern NSString * const kROXWebhookPosted;

#pragma mark - Notification Keys
extern NSString * const kROXKeyGeoRegionId;
extern NSString * const kROXKeyGeoRegionLat;
extern NSString * const kROXKeyGeoRegionLon;
extern NSString * const kROXKeyGeoRegionRadius;
extern NSString * const kROXKeyGeoRegionName;
extern NSString * const kROXKeyGeoRegionTags;

extern NSString * const kROXKeyBeaconId;
extern NSString * const kROXKeyBeaconName;
extern NSString * const kROXKeyBeaconTags;
extern NSString * const kROXKeyBeaconProximityValue;
extern NSString * const kROXKeyBeaconProximityString;

#pragma mark - Devicehook Event Keys
extern NSString * const kROXDevicehookEventKey;
extern NSString * const kROXDevicehookEventRegionEntry;
extern NSString * const kROXDevicehookEventRegionExit;
extern NSString * const kROXDevicehookEventActionTriggered;
extern NSString * const kROXDevicehookEventPlaceVerified;
extern NSString * const kROXDevicehookEventDidCompleteCLVisit;
extern NSString * const kROXDevicehookEventDidPostWebhook;
extern NSString * const kROXDevicehookEventDidFailToPostWebhook;

@end

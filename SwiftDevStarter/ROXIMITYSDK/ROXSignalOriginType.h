//
//  ROXSignalOriginType.h
//  ROXIMITYlib
//
//  Created by Cole Richards on 4/29/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

#ifndef ROXSignalOriginType_h
#define ROXSignalOriginType_h

typedef NS_ENUM(NSInteger, ROXSignalOriginType) {
    ROXSignalOriginTypeNone,
    ROXSignalOriginTypeBeacon,
    ROXSignalOriginTypeGeofence,
    ROXSignalOriginTypeGps,
    ROXSignalOriginTypeWiFi,
    ROXSignalOriginTypePlace
};

#endif /* ROXSignalOriginType_h */

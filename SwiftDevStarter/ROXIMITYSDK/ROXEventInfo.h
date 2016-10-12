//
//  ROXEventInfo.h
//  ROXIMITYlib
//
//  Created by Cole Richards on 4/25/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXPublicActionReporter.h"
#import "ROXPublicSignalReporter.h"
#import "ROXIMITYSignal.h"
#import "ROXIMITYAction.h"

@interface ROXEventInfo : NSObject

-(instancetype)initWithSignalDict:(id <ROXPublicSignalReporter>)signalReporter actionDict:(id <ROXPublicActionReporter>)actionReporter andEventLocation:(CLLocation *)location;

-(ROXIMITYSignal *)getROXIMITYSignal;
-(ROXIMITYAction *)getROXIMITYAction;
-(CLLocation *) getEventLocation;
-(NSTimeInterval)getTimestamp;


@end

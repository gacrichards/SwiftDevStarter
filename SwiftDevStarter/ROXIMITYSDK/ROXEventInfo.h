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

-(instancetype)initWithSignalDict:(id <ROXPublicSignalReporter>)signalReporter andActionDict:(id <ROXPublicActionReporter>)actionReporter;

-(ROXIMITYSignal *)getROXIMITYSignal;
-(ROXIMITYAction *)getROXIMITYAction;
-(NSTimeInterval)getTimestamp;


@end

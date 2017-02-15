//
//  ROXIMITYAction.h
//  ROXIMITYlib
//
//  Created by Cole Richards on 4/25/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXActionPresentationType.h"
#import "ROXSignalEventType.h"

extern NSString * const kROXActionEventUndeliverable;
extern NSString * const kROXActionEventOpened;
extern NSString * const kROXActionEventCancelled;

@interface ROXIMITYAction : NSObject

-(instancetype) initWithDictionary:(NSDictionary *)builderDict;

-(ROXActionPresentationType) getPresentationType;
-(ROXSignalEventType) getEventType;
-(NSString *) getId;
-(NSString *) getName;
-(NSString *)getMessage;
-(NSString *)getUrl;
-(NSSet *)getTags;
-(NSDictionary *)getProperties;
-(NSTimeInterval)getFrequency;
-(NSDate *)getActiveStartDate;
-(NSDate *)getExpiresDate;
-(NSString *)getCorrelationIdentifier;

@end

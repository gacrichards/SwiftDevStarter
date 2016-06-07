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

@interface ROXIMITYAction : NSObject

-(instancetype) initWithDictionary:(NSDictionary *)builderDict;

-(ROXActionPresentationType) getPresentationType;
-(ROXSignalEventType) getEventType;
-(NSString *) getId;
-(NSString *) getName;
-(NSString *)getMessage;
-(NSString *)getUrl;
-(NSSet *)getTags;
-(NSTimeInterval)getFrequency;
-(NSDate *)getActiveStartDateUTC;
-(NSDate *)getExpiresDateUTC;

@end

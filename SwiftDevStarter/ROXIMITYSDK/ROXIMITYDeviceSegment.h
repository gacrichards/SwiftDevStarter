//
//  ROXIMITYDeviceSegment.h
//  ROXIMITYlib
//
//  Created by Cole Richards on 2/9/17.
//  Copyright © 2017 ROXIMITY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ROXIMITYDeviceSegment : NSObject

-(instancetype)initWithSegmentDict:(NSDictionary *)segmentDict;
-(NSDictionary *)getSegmentDictionary;

@end

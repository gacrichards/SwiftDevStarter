//
//  ROXPublicActionReporter.h
//  ROXIMITYlib
//
//  Created by Cole Richards on 4/28/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

#ifndef ROXPublicActionReporter_h
#define ROXPublicActionReporter_h

@protocol ROXPublicActionReporter <NSObject>

@required
- (NSDictionary *)toPublicActionDictionary;
@end
#endif /* ROXPublicActionReporter_h */

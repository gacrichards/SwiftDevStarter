//
//  ROXPublicSignalReporter.h
//  ROXIMITYlib
//
//  Created by Cole Richards on 4/28/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

#ifndef ROXPublicSignalReporter_h
#define ROXPublicSignalReporter_h


@protocol ROXPublicSignalReporter <NSObject>

@required
- (NSDictionary *)toPublicSignalDictionary;
- (BOOL) isApp;
- (NSString *) getId;
@end

#endif /* ROXPublicSignalReporter_h */

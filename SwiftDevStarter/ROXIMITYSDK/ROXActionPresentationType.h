//
//  ROXActionPresentationType.h
//  ROXIMITYlib
//
//  Created by Cole Richards on 4/29/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

#ifndef ROXActionPresentationType_h
#define ROXActionPresentationType_h

typedef NS_ENUM(NSInteger, ROXActionPresentationType) {
    ROXActionPresentationTypeNone,
    ROXActionPresentationTypeNotification,
    ROXActionPresentationTypeRequest,
    ROXActionPresentationTypeWebview,
    ROXActionPresentationTypeWebhookPosted,
    ROXActionPresentationTypeWebhookFailed,
    ROXActionPresentationTypePlaceVerified
};

#endif /* ROXActionPresentationType_h */

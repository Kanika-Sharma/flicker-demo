//
//  FlickrUtility.h
//  FlickerDemo
//
//  Created by Kanika Sharma on 31/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(unsigned int, FKPhotoSize) {
    FKPhotoSizeUnknown = 0,
    FKPhotoSizeCollectionIconLarge,
    FKPhotoSizeBuddyIcon,
    FKPhotoSizeSmallSquare75,
    FKPhotoSizeLargeSquare150,
    FKPhotoSizeThumbnail100,
    FKPhotoSizeSmall240,
    FKPhotoSizeSmall320,
    FKPhotoSizeMedium500,
    FKPhotoSizeMedium640,
    FKPhotoSizeMedium800,
    FKPhotoSizeLarge1024,
    FKPhotoSizeLarge1600,
    FKPhotoSizeLarge2048,
    FKPhotoSizeOriginal,
    FKPhotoSizeVideoOriginal,
    FKPhotoSizeVideoHDMP4,
    FKPhotoSizeVideoSiteMP4,
    FKPhotoSizeVideoMobileMP4,
    FKPhotoSizeVideoPlayer,
};

@interface FlickrUtility : NSObject

+ (FlickrUtility*)sharedUtility;
- (NSURL *) photoURLForSize:(FKPhotoSize)size fromPhotoDictionary:(NSDictionary *)photoDict ;

@end

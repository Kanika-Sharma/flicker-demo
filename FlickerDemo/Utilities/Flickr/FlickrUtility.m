//
//  FlickrUtility.m
//  FlickerDemo
//
//  Created by Kanika Sharma on 31/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import "FlickrUtility.h"


@implementation FlickrUtility

static FlickrUtility* _sharedFlickrController;


+ (FlickrUtility*)sharedUtility
{
    @synchronized(self)
    {
        if (_sharedFlickrController == nil)
        {
            _sharedFlickrController=[[self alloc] init];
        }
    }
    return _sharedFlickrController;
}

// Utility methods to extract the photoID/server/secret/farm from the input
- (NSURL *) photoURLForSize:(FKPhotoSize)size fromPhotoDictionary:(NSDictionary *)photoDict {
    
    //Find possible photoID
    NSString *photoID = [photoDict valueForKey:@"id"];
    if (!photoID) {
        photoID = [photoDict valueForKey:@"primary"]; //sets return this
    }
    
    //Find possible server
    NSString *server = [photoDict valueForKey:@"server"];
    
    //Find possible farm
    NSString *farm = [[photoDict valueForKey:@"farm"] stringValue];
    
    //Find possible secret
    NSString *secret = [photoDict valueForKey:@"secret"];
    
    
    return [self photoURLForSize:size photoID:photoID server:server secret:secret farm:farm];
}

- (NSURL *) photoURLForSize:(FKPhotoSize)size photoID:(NSString *)photoID server:(NSString *)server secret:(NSString *)secret farm:(NSString *)farm {
    // https://farm{farm-id}.static.flickr.com/{server-id}/{id}_{secret}_[mstb].jpg
    // https://farm{farm-id}.static.flickr.com/{server-id}/{id}_{secret}.jpg
    
    static NSString *photoSource = @"https://static.flickr.com/";
    
    NSMutableString *URLString = [NSMutableString stringWithString:@"https://"];
    if (farm.length) {
        [URLString appendFormat:@"farm%@.", farm];
    }
    
    NSAssert([server length], @"Must have server attribute");
    NSAssert([photoID length], @"Must have id attribute");
    NSAssert([secret length], @"Must have secret attribute");
    [URLString appendString:[photoSource substringFromIndex:8]];
    [URLString appendFormat:@"%@/%@_%@", server, photoID, secret];
    
    NSString *sizeKey = FKIdentifierForSize(size);
    [URLString appendFormat:@"_%@.jpg", sizeKey];
    
    return [NSURL URLWithString:URLString];
}

NSString *FKIdentifierForSize(FKPhotoSize size) {
    static NSArray *identifiers = nil;
    if (!identifiers) {
        identifiers = @[@"",
                        @"collectionIconLarge",
                        @"buddyIcon",
                        @"s",
                        @"q",
                        @"t",
                        @"m",
                        @"n",
                        @"",
                        @"z",
                        @"c",
                        @"b",
                        @"h",
                        @"k",
                        @"o",
                        @"",
                        @"",
                        @"",
                        @"",
                        @""];
    }
    return identifiers[size];
}

@end

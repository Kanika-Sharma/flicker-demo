//
//  CommonFunctions.m
//  FlickerDemo
//
//  Created by Kanika Sharma on 01/09/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import "CommonFunctions.h"
#import "Constants.h"

static CommonFunctions* _sharedCommonFunctions;

@implementation CommonFunctions

+ (CommonFunctions*)sharedFunctions
{
    @synchronized(self)
    {
        if (_sharedCommonFunctions == nil)
        {
            _sharedCommonFunctions=[[self alloc] init];
        }
    }
    return _sharedCommonFunctions;
}

- (NSString *)searchURL: (NSString *)searchText withPageNumber : (NSInteger)page
{
    if(searchText.length > 0 && page > 0)
    {
        return [NSString stringWithFormat:@"%@?method=%@&api_key=%@&format=%@&nojsoncallback=%@&safe_search=%@&text=%@&page=%ld",kBaseURL, kMethod, kApiKey, kFormat, kNoJsonCallBack, kSafeSearch, searchText, (long)page];
    }
    else
    {
        return @"error";
    }
}

@end

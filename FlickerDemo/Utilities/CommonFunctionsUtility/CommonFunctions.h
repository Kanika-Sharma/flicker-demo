//
//  CommonFunctions.h
//  FlickerDemo
//
//  Created by Kanika Sharma on 01/09/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonFunctions : NSObject
+ (CommonFunctions*)sharedFunctions;
- (NSString *)searchURL: (NSString *)searchText withPageNumber : (NSInteger)page;
@end

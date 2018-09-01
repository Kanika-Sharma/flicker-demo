//
//  WebServices.h
//  FlickerDemo
//
//  Created by Kanika Sharma on 31/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerProtocol <NSObject>

@end
@interface WebServices : NSObject

+ (WebServices*)sharedController;

@property (nonatomic) SEL selectorMethod;
@property (nonatomic, strong) id<ServerProtocol> delegate;

- (void) getDataFrom:(NSString *)url userInfo:(NSMutableDictionary *)userParams withSelector:(SEL)selector delegate:(id)delegate;
@end

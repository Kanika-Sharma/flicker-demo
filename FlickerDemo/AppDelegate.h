//
//  AppDelegate.h
//  FlickerDemo
//
//  Created by Kanika Sharma on 30/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


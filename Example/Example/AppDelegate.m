//
//  AppDelegate.m
//  Example
//
//  Created by Anders Frank on 2014-11-05.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "AppDelegate.h"
#import "StartTableViewController.h"
#import "TestController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[StartTableViewController new]],

    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

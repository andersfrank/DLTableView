//
//  AppDelegate.m
//  Example
//
//  Created by Anders Frank on 2014-11-05.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "AppDelegate.h"
#import "ToDoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ToDoViewController *toDoViewController = [[ToDoViewController alloc] initWitViewModel:[ToDoViewModel new]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:toDoViewController],
    [self.window makeKeyAndVisible];
    
    [self applyAppearances];
    
    return YES;
}

- (void)applyAppearances {
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.396 green:0.529 blue:0.714 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTranslucent:NO];

}

@end

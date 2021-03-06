//
//  AppDelegate.m
//  毕业设计
//
//  Created by lanou on 16/3/21.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
#import "LoginVC.h"
#import "TabViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _autorX = 375 / [UIScreen mainScreen].bounds.size.width;
    _autorY = 667 / [UIScreen mainScreen].bounds.size.height;
//
    
    //Bmob的应用key
    [Bmob registerWithAppKey:@"64036691de36b4430d2c624df931d1af"];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //判断是否已登录
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLog"] isEqualToString:@"YES"]) {
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TabViewController *tabVC = [story instantiateInitialViewController];
        self.window.rootViewController = tabVC;
        ;
        
    }else
    {
        
                LoginVC *loginVC = [[LoginVC alloc] init];
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
        loginVC.title = @"登录";
        self.window.rootViewController = navi;
        
    }
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

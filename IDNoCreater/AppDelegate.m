//
//  AppDelegate.m
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/4.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "AppDelegate.h"
#import "CreateViewController.h"
#import "CheckViewController.h"
#import "IPCheckViewController.h"

@import GoogleMobileAds;


@interface AppDelegate ()<UITabBarControllerDelegate>

@property(strong,nonatomic) UITabBarController * tabVC;
@property(strong,nonatomic) CreateViewController * createVC;
@property(strong,nonatomic) CheckViewController * checkVC;
@property(strong,nonatomic) IPCheckViewController * ipCheckVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:self.tabVC];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-3058205099381432~7974790223"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if( viewController == self.ipCheckVC )
    {
        self.tabVC.title = @"IP地址校验";
    }
    else if( viewController == self.createVC )
    {
        self.tabVC.title = @"身份证生成";
    }
    else if( viewController == self.checkVC )
    {
        self.tabVC.title = @"身份证校验";
    }
    
    return YES;
}

#pragma setter & getter
-(UITabBarController*)tabVC
{
    if( !_tabVC )
    {
        _tabVC = [UITabBarController new];
        [_tabVC setViewControllers:@[self.createVC,self.checkVC,self.ipCheckVC]];
        _tabVC.title = @"身份证生成";
        _tabVC.delegate = self;
    }
    
    return _tabVC;
}

-(CreateViewController*)createVC
{
    if( !_createVC )
    {
        _createVC = [CreateViewController new];
        _createVC.tabBarItem.title = @"身份证生成";
        _createVC.tabBarItem.image = [UIImage imageNamed:@"a"];
    }
    
    return _createVC;
}

-(IPCheckViewController*)ipCheckVC
{
    if( !_ipCheckVC )
    {
        _ipCheckVC = [IPCheckViewController new];
        _ipCheckVC.tabBarItem.title = @"IP校验";
        _ipCheckVC.tabBarItem.image = [UIImage imageNamed:@"b"];
    }
    
    return _ipCheckVC;
}

-(CheckViewController*)checkVC
{
    if( !_checkVC )
    {
        _checkVC = [CheckViewController new];
        _checkVC.tabBarItem.title = @"身份证校验";
        _checkVC.tabBarItem.image = [UIImage imageNamed:@"c"];
    }
    
    return _checkVC;
}

@end

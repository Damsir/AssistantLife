//
//  AppDelegate.m
//  生活小助手
//
//  Created by qianfeng on 15/11/20.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

#import "DrawerViewController.h"
#import "OptionViewController.h"
#import "TabBarViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
//#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "DestinationLocationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor colorWithRed:0.200 green:0.600 blue:0.800 alpha:1.000] ;
    
    OptionViewController *option = [[OptionViewController alloc]init];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.window.bounds];
    
    image.image = [UIImage imageNamed:@"Option2"];
    
    [self.window addSubview:image];
    
    [self.window sendSubviewToBack:image];

    self.ary = [NSMutableArray array] ;
    
    [self.ary addObject:option];
    
    self.window.rootViewController = [[DrawerViewController alloc]initWithRootViewController:[[TabBarViewController alloc]init] andLeftViewController:option andRightViewController:[[UIViewController alloc]init]];
    
    [self.window makeKeyAndVisible];
    
    [UMSocialData setAppKey:@"56679982e0f55a82ee00155c"];
    [UMSocialWechatHandler setWXAppId:@"wx0e828efb9373aaa1" appSecret:@"e77aaeef1149daa4e317000a088e20b2" url:@"http://weibo.com/u/5780063948/home"];
    
    UIApplicationShortcutItem * itemy = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"打开应用" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
    UIApplicationShortcutItem * itemx = [[UIApplicationShortcutItem alloc]initWithType:@"one" localizedTitle:@"定位" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    //    UIApplicationShortcutItem *itemz=[[UIApplicationShortcutItem alloc] initWithType:@"three" localizedTitle:@"分享应用"];
    [UIApplication sharedApplication].shortcutItems = @[itemx,itemy];
    
    
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url];
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    if ([shortcutItem.type isEqualToString:@"one"])
    {
        DestinationLocationViewController *vc=[[DestinationLocationViewController alloc]init];
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDEMAX, 64)];
        view.backgroundColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
        [vc.view addSubview:view];
        [vc.view bringSubviewToFront:view];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(10, 27, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"ButtonBack2_Pressed"] forState:UIControlStateNormal];
        [view addSubview:btn];
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake((WIDEMAX-60)/2, 20, 60, 30)];
        lab.text=@"定位";
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        [view addSubview:lab];
        [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
        
        
    }
    if ([shortcutItem.type isEqualToString:@"two"])
    {
        
        
        
    }

// 布置主界面

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

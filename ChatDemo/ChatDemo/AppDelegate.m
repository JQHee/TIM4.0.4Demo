//
//  AppDelegate.m
//  ChatDemo
//
//  Created by midland on 2019/3/11.
//  Copyright © 2019年 midland. All rights reserved.
//

#import "AppDelegate.h"

#define sdkAppid          1400193161
#define sdkAccountType    @"36862"

@interface AppDelegate () <TAlertViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initTMImSDK];
    // [self registNotification];
    return YES;
}

- (void) initTMImSDK {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onForceOffline:) name:TUIKitNotification_TIMUserStatusListener object:nil];
    [[TUIKit sharedInstance] initKit:sdkAppid accountType:sdkAccountType withConfig:[TUIKitConfig defaultConfig]];
}

- (void)onForceOffline:(NSNotification *)notification
{
    TAlertView *alert = [[TAlertView alloc] initWithTitle:@"账号在其他终端登录"];
    alert.delegate = self;
    [alert showInWindow:self.window];
}

- (void)didConfirmInAlertView:(TAlertView *)alertView
{
    
}

- (void)didCancelInAlertView:(TAlertView *)alertView {
    
}

// 集成离线推送
- (void)registNotification
{
    TIMAPNSConfig *config = [[TIMAPNSConfig alloc]init];
    [config setOpenPush:1];
    [[TIMManager sharedInstance] setAPNS:config succ:^{
        
    } fail:^(int code, NSString *msg) {
        
    }];
}
/**
 *  在AppDelegate的回调中会返回DeviceToken，需要在登录后上报给腾讯云后台
 **/
 -(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
 {
     [self configOnAppRegistAPNSWithDeviceToken:deviceToken];
 }

- (void)configOnAppRegistAPNSWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    [[TIMManager sharedInstance] log:TIM_LOG_INFO tag:@"SetToken" msg:[NSString stringWithFormat:@"My Token is :%@", token]];
    TIMTokenParam *param = [[TIMTokenParam alloc] init];
    /* 用户自己到苹果注册开发者证书，在开发者帐号中下载并生成证书(p12 文件)，将生成的 p12 文件传到腾讯证书管理控制台，控制台会自动生成一个证书 ID，将证书 ID 传入一下 busiId 参数中。*/
#if kAppStoreVersion
    // App Store 版本
#if DEBUG
    param.busiId = 2383;
#else
    param.busiId = 2382;
#endif
#else
    //企业证书 ID
    param.busiId = 2516;
#endif
    [param setToken:deviceToken];
    //    [[TIMManager sharedInstance] setToken:param];
    [[TIMManager sharedInstance] setToken:param succ:^{
        NSLog(@"-----> 上传 token 成功 ");
    } fail:^(int code, NSString *msg) {
        NSLog(@"-----> 上传 token 失败 ");
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    __block UIBackgroundTaskIdentifier bgTaskID;
    bgTaskID = [application beginBackgroundTaskWithExpirationHandler:^ {
        //不管有没有完成，结束 background_task 任务
        [application endBackgroundTask: bgTaskID];
        bgTaskID = UIBackgroundTaskInvalid;
    }];
    [self configOnAppEnterBackground];
}

- (void)configOnAppEnterBackground
{
    /*
    TIMBackgroundParam  *param = [[TIMBackgroundParam alloc] init];
    //[param setC2cUnread:(int)unReadCount];
    [[TIMManager sharedInstance] doBackground:param succ:^() {
        DebugLog(@"doBackgroud Succ");
    } fail:^(int code, NSString * err) {
        DebugLog(@"Fail: %d->%@", code, err);
    }];
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[TIMManager sharedInstance] doForeground:^() {
       
    } fail:^(int code, NSString * err) {
    
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

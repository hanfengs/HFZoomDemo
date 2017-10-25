//
//  AppDelegate.m
//  zoomDemo
//
//  Created by hanfeng on 2017/10/25.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "AppDelegate.h"
#import <MobileRTC/MobileRTC.h>

#define kZoomSDKAppKey      @"v3XQK422HF76heLI11rXdMIAPhN5HFKDuS0x"
#define kZoomSDKAppSecret   @"58kFpYYLqOA70U2DLlX99BQMjFTtmaA6odoi"
#define kZoomSDKDomain      @"zoom.us"

#define kZoomSDKEmail       @""
#define kZoomSDKPassword    @""

@interface AppDelegate ()<MobileRTCAuthDelegate, MobileRTCPremeetingDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSLog(@"MobileRTC Version: %@", [[MobileRTC sharedRTC] mobileRTCVersion]);
    //1. Set MobileRTC Domain
    [[MobileRTC sharedRTC] setMobileRTCDomain:kZoomSDKDomain];
    
    [self sdkAuth];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [[MobileRTC sharedRTC] appWillResignActive];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[MobileRTC sharedRTC] appDidEnterBackgroud];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
     [[MobileRTC sharedRTC] appDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Auth Delegate

- (void)sdkAuth
{
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
    if (authService)
    {
        authService.delegate = self;
        
        authService.clientKey = kZoomSDKAppKey;
        authService.clientSecret = kZoomSDKAppSecret;
        
        [authService sdkAuth];
    }
}

- (void)onMobileRTCAuthReturn:(MobileRTCAuthError)returnValue
{
    NSLog(@"onMobileRTCAuthReturn %d", returnValue);
    
    if (returnValue != MobileRTCAuthError_Success)
    {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"SDK authentication failed, error code: %zd", @""), returnValue];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:NSLocalizedString(@"Retry", @""), nil];
        [alert show];
    }
    else
    {
        MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
        if (authService)
        {
            [authService loginWithEmail:kZoomSDKEmail password:kZoomSDKPassword];
        }
    }
}

- (void)onMobileRTCLoginReturn:(NSInteger)returnValue
{
    NSLog(@"onMobileRTCLoginReturn result=%zd", returnValue);
    
    MobileRTCPremeetingService *service = [[MobileRTC sharedRTC] getPreMeetingService];
    if (service)
    {
        service.delegate = self;
    }
}

- (void)onMobileRTCLogoutReturn:(NSInteger)returnValue
{
    NSLog(@"onMobileRTCLogoutReturn result=%zd", returnValue);
}


#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self performSelector:@selector(sdkAuth) withObject:nil afterDelay:0.f];
    }
}

#pragma mark - Premeeting Delegate


- (void)sinkSchedultMeeting:(NSInteger)result
{
    NSLog(@"sinkSchedultMeeting result: %zd", result);
}

- (void)sinkEditMeeting:(NSInteger)result
{
    NSLog(@"sinkEditMeeting result: %zd", result);
}

- (void)sinkDeleteMeeting:(NSInteger)result
{
    NSLog(@"sinkDeleteMeeting result: %zd", result);
}

- (void)sinkListMeeting:(NSInteger)result withMeetingItems:(NSArray*)array
{
    NSLog(@"sinkSchedultMeeting result: %zd  items: %@", result, array);
}


@end

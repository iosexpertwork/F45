//
//  AppDelegate.m
//  F45
//
//  Created by TED Solutions on 25/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "playBookVC.h"
#import "RightViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //f45training.freshdesk.com   yogeshparas.freshdesk.com
    MobihelpConfig *config = [[MobihelpConfig alloc]initWithDomain:@"f45training.freshdesk.com" withAppKey:FRESHDESK_APP_KEY andAppSecret:FRESHDESK_APP_SECRET];
    [config setThemeName:@"FDLightTheme"];
    [[Mobihelp sharedInstance]initWithConfig:config];
    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"email"])
//    {
//        UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        SupportViewController* pvc = [mainstoryboard instantiateViewControllerWithIdentifier:@"support"];
//        UINavigationController *navController=[mainstoryboard instantiateViewControllerWithIdentifier:@"navigation"];
//        self.window.rootViewController=navController;
//        [navController setViewControllers:@[pvc]];
//    }
    
    [[UINavigationBar appearance] setBarTintColor:APP_COLOR];
   // [[UINavigationBar appearance] setTranslucent:NO];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    // Register Push notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    return YES;
}
-(void)mainViewSwitch:(UIViewController *)controller
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController * navigation=[storyboard instantiateViewControllerWithIdentifier:@"navigation"];
    [navigation setViewControllers:@[controller]];
    
    RightViewController * rightViewController_O=[storyboard instantiateViewControllerWithIdentifier:@"drawer"];
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:navigation
                                             leftDrawerViewController:rightViewController_O
                                             rightDrawerViewController:nil];
    [drawerController setMaximumLeftDrawerWidth:220];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.window setRootViewController:drawerController];
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

#pragma mark  Push Notification

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"token"]==nil)
    {
        NSLog(@"My token is: %@", deviceToken);
        const unsigned *tokenBytes = [deviceToken bytes];
        NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        
        NSLog(@"Hex=%@",hexToken);
        [defaults setObject:hexToken forKey:@"token"];
        [defaults synchronize];
    }
    else
    {
        NSLog(@"Already has token");
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Notification %@",userInfo);
    
    if ( application.applicationState == UIApplicationStateActive )
    {
        
    }
}

+(BOOL)notificationServicesEnabled
{
    BOOL isEnabled = NO;
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){
        UIUserNotificationSettings *notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (!notificationSettings || (notificationSettings.types == UIUserNotificationTypeNone)) {
            isEnabled = NO;
        } else {
            isEnabled = YES;
        }
    } else {
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (types & UIRemoteNotificationTypeAlert) {
            isEnabled = YES;
        } else{
            isEnabled = NO;
        }
    }
    return isEnabled;
}

@end

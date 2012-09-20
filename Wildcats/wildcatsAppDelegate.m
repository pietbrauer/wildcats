//
//  WildcatsAppDelegate.m
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "wildcatsAppDelegate.h"
#import "NavigationController.h"
#import "FlurryAnalytics.h"


@implementation wildcatsAppDelegate
@synthesize rootController;
@synthesize navigationController;


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [FlurryAnalytics startSession:@"2PQ9122YGVNVL98AX817"];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    navigationController = [[NavigationController alloc] init];
    [FlurryAnalytics logAllPageViews:self.navigationController];
    [self setNavigationController:navigationController];
  
    [self.window addSubview:rootController.view];
    [self.window makeKeyAndVisible];
    
    if ([self.window respondsToSelector:@selector(setRootViewController:)]) {
        [self.window setRootViewController:rootController];
    }
    //show Splashscreen for 2.5 seconds
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [NSThread sleepUntilDate:future];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![[prefs objectForKey:@"wildcats_alert_dialog"] isEqualToString:@"1"]) {
        
        UIDevice *device = [UIDevice currentDevice];
        
        if ([[device.systemVersion substringFromIndex:1] intValue] < 5 ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upgrade" message:@"Diese App wurde auf iOS 5 optimiert. Bitte aktualisieren Sie Ihr Telefon auf die neueste Systemversion mithilfe von iTunes." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [prefs setObject:[NSString stringWithString:@"1"] forKey:@"wildcats_alert_dialog"];
            [prefs synchronize];
        }
    }
    
    

}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


@end

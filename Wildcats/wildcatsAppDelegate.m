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

#import "NewstickerTableViewController.h"
#import "InfoTableViewController.h"
//#import "ChartTableViewController.h"
//#import "ScheduleTableViewController.h"
#import "BrowserViewController.h"
#import "SpaceTableViewController.h"
#import "LivetickerViewController.h"


@implementation wildcatsAppDelegate
@synthesize rootController;
@synthesize navigationController;


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [FlurryAnalytics startSession:@"2PQ9122YGVNVL98AX817"];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [rootController setViewControllers:[self loadViewController]];
    
    if ([self.window respondsToSelector:@selector(setRootViewController:)]) {
        [self.window setRootViewController:rootController];
    }
    
    [self.window addSubview:rootController.view];
    [self.window makeKeyAndVisible];
    

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
            [prefs setObject:@"1" forKey:@"wildcats_alert_dialog"];
            [prefs synchronize];
        }
    }
    
    

}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

-(NSArray *)loadViewController{
    BrowserViewController *scheduleViewController = [[BrowserViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    NavigationController *ScheduleNavController = [[NavigationController alloc] initWithRootViewController:scheduleViewController];
    
    BrowserViewController *tableViewController = [[BrowserViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.apple.com"]];
    NavigationController *tableNavController = [[NavigationController alloc] initWithRootViewController:tableViewController];
    
    NewstickerTableViewController *newsController = [[NewstickerTableViewController alloc] initWithStyle:UITableViewStylePlain];
    NavigationController *newsNavController = [[NavigationController alloc] initWithRootViewController:newsController];
    
    SpaceTableViewController *spacesController = [[SpaceTableViewController alloc] initWithStyle:UITableViewStylePlain];
    NavigationController *spacesNavController = [[NavigationController alloc] initWithRootViewController:spacesController];
    
    LivetickerViewController *livetickerController = [[LivetickerViewController alloc] initWithNibName:@"LivetickerViewController" bundle:nil];
    NavigationController *tickerNavController = [[NavigationController alloc] initWithRootViewController:livetickerController];
    
    NSArray *array = @[ScheduleNavController, tableNavController, newsNavController, spacesNavController, tickerNavController];
    
    return array;
}


@end

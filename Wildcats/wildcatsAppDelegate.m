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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [rootController setViewControllers:[self loadViewController]];
    
    if ([self.window respondsToSelector:@selector(setRootViewController:)]) {
        [self.window setRootViewController:rootController];
    } else{
        [self.window addSubview:rootController.view];
    }
    
    [self.window makeKeyAndVisible];
    
    [self setupWebServices];
    
    //show Splashscreen for 2.5 seconds
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [NSThread sleepUntilDate:future];
    return YES;
}

-(void)setupWebServices{
    [TestFlight takeOff:@"8b8072569c3a204d060dc40c27bfce45_NTY5NjMyMDEyLTAxLTI2IDA4OjI3OjAwLjMyODUwMg"];
    [FlurryAnalytics startSession:@"2PQ9122YGVNVL98AX817"];
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

-(NSArray *)loadViewController{
    //
    NSString *tableString = @"<script src=\"http://www.handball-world.com/o.red.c/extern/tablebox.php?gender=2&cstLiga=36&cstPhase=90&cstLang=1&cstCharset=1&width=300\" type=\"text/javascript\"></script>";
    
    NSString *scheduleString = @"<script src=\"http://www.handball-world.com/hbf/extern/gamesbox.php?gender=2&cstLiga=36&cstLang=1&cstLmt=10&cstCharset=1&width=300\" type=\"text/javascript\"></script>";
    
    BrowserViewController *scheduleViewController = [[BrowserViewController alloc] initWithScript:scheduleString andTitle:@"Spielplan"];
    NavigationController *scheduleNavController = [[NavigationController alloc] initWithRootViewController:scheduleViewController];
    UITabBarItem *scheduleItem = [[UITabBarItem alloc] initWithTitle:@"Spielplan" image:[UIImage imageNamed:@"icon_calendar.png"] tag:0];
    scheduleNavController.tabBarItem = scheduleItem;
    
    BrowserViewController *tableViewController = [[BrowserViewController alloc] initWithScript:tableString andTitle:@"Tabelle"];
    NavigationController *tableNavController = [[NavigationController alloc] initWithRootViewController:tableViewController];
    UITabBarItem *tableItem = [[UITabBarItem alloc] initWithTitle:@"Tabelle" image:[UIImage imageNamed:@"icon_chart.png"] tag:0];
    tableNavController.tabBarItem = tableItem;
    
    NewstickerTableViewController *newsController = [[NewstickerTableViewController alloc] initWithStyle:UITableViewStylePlain];
    NavigationController *newsNavController = [[NavigationController alloc] initWithRootViewController:newsController];
    UITabBarItem *newsItem = [[UITabBarItem alloc] initWithTitle:@"News" image:[UIImage imageNamed:@"NewsIcon.png"] tag:0];
    newsNavController.tabBarItem = newsItem;
    
//    SpaceTableViewController *spacesController = [[SpaceTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    NavigationController *spacesNavController = [[NavigationController alloc] initWithRootViewController:spacesController];
//    UITabBarItem *spacesItem = [[UITabBarItem alloc] initWithTitle:@"Spielorte" image:[UIImage imageNamed:@"icon_spaces.png"] tag:0];
//    spacesNavController.tabBarItem = spacesItem;
    
    LivetickerViewController *livetickerController = [[LivetickerViewController alloc] initWithNibName:@"LivetickerViewController" bundle:nil];
    NavigationController *tickerNavController = [[NavigationController alloc] initWithRootViewController:livetickerController];
    UITabBarItem *ticketItem = [[UITabBarItem alloc] initWithTitle:@"Liveticker" image:[UIImage imageNamed:@"11-clock.png"] tag:0];
    tickerNavController.tabBarItem = ticketItem;
    
    NSArray *array = @[scheduleNavController, tableNavController, newsNavController, tickerNavController];
    
    return array;
}


@end

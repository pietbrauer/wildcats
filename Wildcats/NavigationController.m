//
//  NavigationController.m
//  Wildcats
//
//  Created by Piet Brauer on 11.05.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "NavigationController.h"
#import "InfoTableViewController.h"
#import "FlurryAnalytics.h"

@implementation NavigationController
@synthesize adShowMeSomething, passString;


-(IBAction)showInfoView:(id)sender{
    InfoTableViewController *infoTableView = [[InfoTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [FlurryAnalytics logEvent:@"InfoView"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:infoTableView];
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:navController animated:YES];
    
}
-(void)showWebsite:(id)sender{
    [FlurryAnalytics logEvent:@"Ad"];
    NSString *urlString = [NSString stringWithFormat:@"http://www.waschsalon-halle.de"];
    NSURL *profileURL = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:profileURL];
}

-(void)showMaps:(id)sender{
    NSString *title = @"SB-Waschsalon";
    float latitude = 51.48643;
    float longitude = 11.97436;
    int zoom = 50;
    [FlurryAnalytics logEvent:@"Ad"];
    NSString *stringURL = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@@%1.6f,%1.6f&z=%d", title, latitude, longitude, zoom];
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}
-(void)showFacebook:(id)sender{
    [FlurryAnalytics logEvent:@"Ad"];
    NSString *urlString = [NSString stringWithFormat:@"http://touch.facebook.com/SB.Waschsalon?view=wall"];
    NSURL *profileURL = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:profileURL];
}

#pragma mark - View lifecycle
#define kAddressTag 0
#define kHoursTag 1
#define kFacebookTag 2
#define kURLTag 3

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"Index: %i",self.tabBarController.selectedIndex);
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, 392, 320, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 392, 320, 40)];
    [self.navigationBar setTintColor:[UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1]];
    
    
    //switch between each tabbar item
    //showWebsite, showFacebook Page, show Maps on Banner touch
    
    if (self.tabBarController.selectedIndex > 3) {
        [button addTarget:self action:@selector(showMaps:) forControlEvents:UIControlEventTouchDown];
        adView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Banner1.png"]];
        adView.tag = kAddressTag;
    } else if (self.tabBarController.selectedIndex == 0) {
        [button addTarget:self action:@selector(showWebsite:) forControlEvents:UIControlEventTouchDown];
        adView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Banner2.png"]];
        adView.tag = kURLTag;
    } else if (self.tabBarController.selectedIndex == 1) {
        [button addTarget:self action:@selector(showFacebook:) forControlEvents:UIControlEventTouchDown];
        adView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Banner3.png"]];
        adView.tag = kFacebookTag;
    }else if (self.tabBarController.selectedIndex == 2) {
        [button addTarget:self action:@selector(showWebsite:) forControlEvents:UIControlEventTouchDown];
        adView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Banner4.png"]];
        adView.tag = kHoursTag;
    } else{
        [button addTarget:self action:@selector(showFacebook:) forControlEvents:UIControlEventTouchDown];
        adView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Banner3.png"]];
        adView.tag = kFacebookTag;
    }
    
    adView.alpha = 1;
    
    [self.view addSubview:adView];
    [self.view addSubview:button];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

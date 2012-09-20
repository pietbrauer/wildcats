//
//  WildcatsAppDelegate.h
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavigationController;
@class BWHockeyManager;

@interface wildcatsAppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate> {
    //TabBar is RootViewController
    IBOutlet UITabBarController *rootController;
    NavigationController *navigationController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet UITabBarController *rootController;
@property (nonatomic, strong) NavigationController *navigationController;

@end

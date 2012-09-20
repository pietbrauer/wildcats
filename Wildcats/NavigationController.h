//
//  NavigationController.h
//  Wildcats
//
//  Created by Piet Brauer on 11.05.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationController : UINavigationController <UINavigationControllerDelegate, UINavigationBarDelegate> {
    UIButton *adShowMeSomething;
    NSString *passString;
}

-(IBAction)showInfoView:(id)sender;
-(void)showWebsite:(id)sender;
-(void)showMaps:(id)sender;
-(void)showFacebook:(id)sender;

@property (nonatomic, strong) UIButton *adShowMeSomething;
@property (nonatomic, strong) NSString *passString;
@end

//
//  InfoTableViewController.h
//  wildcats
//
//  Created by Piet Brauer on 08.01.12.
//  Copyright (c) 2012 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface InfoTableViewController : UITableViewController <MFMailComposeViewControllerDelegate>{
    NSString *pietText;
    NSString *sportWerkText;
}

-(void)dismiss:(id)sender;

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

-(void)displayComposerSheetSportwerk;
-(void)launchMailAppOnDeviceSportwerk;

@end

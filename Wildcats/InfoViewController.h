//
//  InfoViewController.h
//  Wildcats
//
//  Created by Piet Brauer on 17.05.11.
//  Copyright 2011 GRAVIS Computervertriebsgesellschaft mbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
}


-(IBAction)dismissInfoView:(id)sender;

-(IBAction)mailMe:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

-(IBAction)mailSportwerk:(id)sender;
-(void)displayComposerSheetSportwerk;
-(void)launchMailAppOnDeviceSportwerk;
@end

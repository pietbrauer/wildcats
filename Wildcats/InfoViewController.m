//
//  InfoViewController.m
//  Wildcats
//
//  Created by Piet Brauer on 17.05.11.
//  Copyright 2011 GRAVIS Computervertriebsgesellschaft mbH. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoView.h"
#import "FlurryAnalytics.h"

@implementation InfoViewController

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated{
    [FlurryAnalytics logEvent:@"InfoView"];
    
    [super viewWillAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)dismissInfoView:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - OwnMethods

-(void)mailMe:(id)sender{
    [FlurryAnalytics logEvent:@"Info - MailPiet"];
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}

#pragma mark - Compose Developer Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker.navigationBar setTintColor:[UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1]];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"SV UNION Halle-Neustadt iPhone App Anfrage"];
	
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"piet@nerdishbynature.com"];  
	
	[picker setToRecipients:toRecipients];
    
	
	// Fill out the email body text
	NSString *emailBody = [NSString stringWithFormat:@"Hallo,\n "];
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)mailSportwerk:(id)sender{
    [FlurryAnalytics logEvent:@"Info - Mail Sportwerk"];
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheetSportwerk];
		}
		else
		{
			[self launchMailAppOnDeviceSportwerk];
		}
	}
	else
	{
		[self launchMailAppOnDeviceSportwerk];
	}
}
-(void)displayComposerSheetSportwerk{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker.navigationBar setTintColor:[UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1]];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"SV UNION Halle-Neustadt iPhone App Anfrage"];
	
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"info@sportwerk.net"];  
	
	[picker setToRecipients:toRecipients];
    
	
	// Fill out the email body text
	NSString *emailBody = [NSString stringWithFormat:@"Hallo,\n "];
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:piet@nerdishbynature.com?&subject=SV UNION Halle Neustadt";
	NSString *body = @"Hallo";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(void)launchMailAppOnDeviceSportwerk{
    NSString *recipients = @"mailto:inof@sportwerk.de?&subject=SV UNION Halle Neustadt";
	NSString *body = @"Hallo";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


@end

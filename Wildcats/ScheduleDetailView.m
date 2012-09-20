//
//  ScheduleDetailView.m
//  Wildcats
//
//  Created by Piet Brauer on 25.05.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "ScheduleDetailView.h"
#import "FlurryAnalytics.h"

@implementation ScheduleDetailView
@synthesize imageHome;
@synthesize imageGuest;
@synthesize labelHome;
@synthesize labelGuest;
@synthesize result;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [FlurryAnalytics logEvent:@"Schedule - Detail"];
    [super viewDidLoad];
    labelHome.font = [UIFont boldSystemFontOfSize:18];
    labelHome.numberOfLines = ceilf([[labelHome text] sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
    labelGuest.font = [UIFont boldSystemFontOfSize:18];
    labelGuest.numberOfLines = ceilf([[labelGuest text] sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  NewsTickerDetailView.m
//  Wildcats
//
//  Created by Piet Brauer on 06.04.11.
//  Copyright 2011 GRAVIS Computervertriebsgesellschaft mbH. All rights reserved.
//

#import "NewsTickerDetailView.h"
#import "FlurryAnalytics.h"


@implementation NewsTickerDetailView
@synthesize articleTexView;
@synthesize headlineLabel;


- (void)dealloc
{
    [articleTexView release];
    [headlineLabel release];
    [super dealloc];
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
    [super viewDidLoad];
    [FlurryAnalytics logEvent:@"News - Detail"];
    //set Size and Number of Lines for headlineLabel
	headlineLabel.font = [UIFont boldSystemFontOfSize:18];
	headlineLabel.numberOfLines = ceilf([[headlineLabel text] sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

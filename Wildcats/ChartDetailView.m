//
//  ScheduleDetailView.m
//  Wildcats
//
//  Created by Piet Brauer on 25.05.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "ChartDetailView.h"
#import "FlurryAnalytics.h"


@implementation ChartDetailView

@synthesize imageView;
@synthesize position;
@synthesize games;
@synthesize stats;
@synthesize goals;
@synthesize team;
@synthesize points;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [FlurryAnalytics logEvent:@"Chart - Detail"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

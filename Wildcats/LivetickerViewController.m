//
//  LivetickerViewController.m
//  wildcats
//
//  Created by Piet Brauer on 08.01.12.
//  Copyright (c) 2012 nerdish by nature. All rights reserved.
//

#import "LivetickerViewController.h"

@implementation LivetickerViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(void)refreshWebView:(id)sender{
    [webView reload];
}

-(void)backWebView:(id)sender{
    [webView goBack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Liveticker"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.sis-handball.de/live/hbvf/?liga=001512000000000000000000000000000011000"]];
    [webView loadRequest:request];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshWebView:)];
    [self.navigationItem setRightBarButtonItem:refreshItem];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(backWebView:)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    // Do any additional setup after loading the view from its nib.
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

//
//  NewsDetailTableViewController.m
//  wildcats
//
//  Created by Piet Brauer on 07.01.12.
//  Copyright (c) 2012 nerdish by nature. All rights reserved.
//

#import "NewsDetailTableViewController.h"


@implementation NewsDetailTableViewController
@synthesize text;
@synthesize headline;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:headline];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = headline;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            cell.textLabel.numberOfLines = ceilf([headline sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
        }
            break;
        case 1:{
            cell.textLabel.text = text;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.numberOfLines = ceilf([text sizeWithFont:[UIFont boldSystemFontOfSize:15] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0)+3;
        }
            break;
        default:{
            //return no textLabel
            cell.textLabel.text = @"";
        }
            break;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //calculating and returning Cell Height
    CGSize titleSize;
    CGSize detailSize;
    if (indexPath.row == 0) {
        titleSize = [headline sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        return titleSize.height+5;
    } else if (indexPath.row == 1) {
        detailSize = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeHeadTruncation];
        return detailSize.height+50;
    } else{
        return 40;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end

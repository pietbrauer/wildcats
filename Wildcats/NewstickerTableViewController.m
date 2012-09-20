//
//  NewstickerTableViewController.m
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "NewstickerTableViewController.h"
#import "NewsTickerDetailView.h"
#import "NewsDetailTableViewController.h"
#import "FlurryAnalytics.h"


@implementation NewstickerTableViewController
//@synthesize newsCell;
@synthesize newstickerDetailView;

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    
    if (self) {
        self.title = @"News";
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
    [FlurryAnalytics logEvent:@"News"];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    //make Background (of AppDelegate) visible
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIColor *navColor = [UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1];
	self.navigationController.navigationBar.tintColor = navColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadNews:)];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([posts count] == 0) {
        [self loadNews:nil];
    }
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //Every second Cell gets gray Background
        if ([[[posts objectAtIndex:indexPath.row] objectForKey:@"article"] length] <= 5) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
        bg.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        
        if ((indexPath.row%2) == 1) {
            cell.backgroundView = bg;
        }
        
    }

    //parsing data out of XML & Change the Cell Size dynamicly
    cell.textLabel.text = [[posts objectAtIndex:indexPath.row] objectForKey:@"headline"];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
	cell.textLabel.numberOfLines = ceilf([[[posts objectAtIndex:indexPath.row] objectForKey:@"headline"] sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
    
	cell.detailTextLabel.text = [[posts objectAtIndex:indexPath.row] objectForKey:@"teaser"];
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
	cell.detailTextLabel.numberOfLines = ceilf([[[posts objectAtIndex:indexPath.row] objectForKey:@"teaser"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //calculating and returning Cell Height
	NSString *titleString = [[posts objectAtIndex:indexPath.row] objectForKey:@"headline"];
	NSString *detailString = [[posts objectAtIndex:indexPath.row] objectForKey:@"teaser"];
	CGSize titleSize = [titleString sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
	CGSize detailSize = [detailString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

    return detailSize.height+titleSize.height+10;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    if ([[[posts objectAtIndex:indexPath.row] objectForKey:@"article"] length] <= 5) {
        
   } else{
        NewsDetailTableViewController *detailViewController = [[NewsDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController.navigationItem setTitle:[[posts objectAtIndex:indexPath.row] objectForKey:@"headline"]];
        [detailViewController setHeadline:[[posts objectAtIndex:indexPath.row] objectForKey:@"headline"]];
        [detailViewController setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"article"]];
    }
    
}

#pragma mark - XML Stuff

-(void)loadNews:(id)sender{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //URL to XML Direction
    NSString *path = @"http://www.union-halle.net/news.xml.php";
    //NSString *path = @"http://beta.nerdishbynature.com/news.xml";
    [self parseXMLFileAtURL:path];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)parseXMLFileAtURL:(NSString *)URL{
    posts = [[NSMutableArray alloc] init];
    NSURL *xmlURL = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:xmlURL];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (!error) {
                                   xmlParser = [[NSXMLParser alloc] initWithData:data];
                                   [xmlParser setDelegate:self];
                                   [xmlParser parse];
                               } else{
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hinweis"
                                                                                   message:@"Möglicherweise besteht gerade keine Internetverbindung."
                                                                                  delegate:self
                                                                         cancelButtonTitle:@""
                                                                          otherButtonTitles:nil];
                                   
                                   [alert show];
                               }
        
    }];
}
    
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
        currentElement = [elementName copy];
        if ([elementName isEqualToString:@"item"]) {
            item = [[NSMutableDictionary alloc] init];
            currentDate = [[NSMutableString alloc] init];
            currentHeadline = [[NSMutableString alloc] init];
            currentTeaser = [[NSMutableString alloc] init];
            currentArticle = [[NSMutableString alloc] init];
        }
    }
    
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
        if ([elementName isEqualToString:@"item"]){
            [item setObject:currentDate forKey:@"date"];
            [item setObject:currentHeadline forKey:@"headline"];
            [item setObject:currentTeaser forKey:@"teaser"];
            [item setObject:currentArticle forKey:@"article"];
            [posts addObject:[item copy]];
       }
}
    
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
        if ([currentElement isEqualToString:@"date"]){
            [currentDate appendString:string];
        } else if ([currentElement isEqualToString:@"headline"]) {
            [currentHeadline appendString:string];
        }
        else if ([currentElement isEqualToString:@"teaser"]) {
            [currentTeaser appendString:string];
        }
        else if ([currentElement isEqualToString:@"article"]) {
            [currentArticle appendString:string];
      }
}
   
- (void)parserDidEndDocument:(NSXMLParser *)parser{
        [self.tableView reloadData];
}


@end

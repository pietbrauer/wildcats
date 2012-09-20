//
//  SpaceTableViewController.m
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "SpaceTableViewController.h"
#import "SpaceDetailView.h"
#import "FlurryAnalytics.h"


@implementation SpaceTableViewController
@synthesize spaceCell, spaceDetailView;

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    
    if (self) {
        self.title = @"Spielorte";
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [FlurryAnalytics logEvent:@"Space"];
    if ([posts count] == 0) {
        [self loadSpaces:nil];
	}
    //Define NavigationBar Color
    UIColor *navColor = [UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1];
	self.navigationController.navigationBar.tintColor = navColor;
    //Add Refresh Button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadSpaces:)];
    [super viewWillAppear:YES];
}

-(void)loadSpaces:(id)sender{
    //Setting the URL of XML
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *path = @"http://beta.nerdishbynature.com/spaces.xml";
    [self parseXMLFileAtURL:path];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
        
        [[NSBundle mainBundle] loadNibNamed:@"SpaceCell" owner:self options:nil];
        cell = spaceCell;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //Every second Cell gets gray Background
        UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
        bg.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        if ((indexPath.row%2) == 1) {
            cell.backgroundView = bg;
        }
        
        self.spaceCell = nil;
    }
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *cityLabel = (UILabel *)[cell viewWithTag:2];
    
    [nameLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [cityLabel setText:[NSString stringWithFormat:@"%@, %@",[[posts objectAtIndex:indexPath.row] objectForKey:@"address"],[[posts objectAtIndex:indexPath.row] objectForKey:@"city"]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //last cell gets a 30px higher, because of the Ad Banner
    if (indexPath.row == [posts count]-1) {
        return 100;
    } else {
	return 70;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     SpaceDetailView *detailViewController = [[SpaceDetailView alloc] initWithNibName:@"SpaceDetailView" bundle:nil];
     // Pass the selected object to the new view controller.
    //Setting Address for MKMapView
    [detailViewController setAddress:[NSString stringWithFormat:@"%@,%@ %@",[[posts objectAtIndex:indexPath.row] objectForKey:@"address"],[[posts objectAtIndex:indexPath.row] objectForKey:@"postcode"], [[posts objectAtIndex:indexPath.row] objectForKey:@"city"]]];

    //Set MapView Type
    [detailViewController.mapView setMapType:MKMapTypeHybrid];
    
    //set title of DetailView
    [detailViewController setTitle:[NSString stringWithFormat:@"%@",[[posts objectAtIndex:indexPath.row] objectForKey:@"name"]]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - XML Stuff
-(void)parseXMLFileAtURL:(NSString *)URL{
	posts = [[NSMutableArray alloc] init];
	NSURL *xmlURL = [NSURL URLWithString:URL];
	xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	[xmlParser setDelegate:self];
	[xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		item = [[NSMutableDictionary alloc] init];
		currentName = [[NSMutableString alloc] init];
        currentCity = [[NSMutableString alloc] init];
        currentPostcode = [[NSMutableString alloc] init];
        currentAddress = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]){
		[item setObject:currentName forKey:@"name"];
		[item setObject:currentCity forKey:@"city"];
        [item setObject:currentPostcode forKey:@"postcode"];
        [item setObject:currentAddress forKey:@"address"];		
		[posts addObject:[item copy]];
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([currentElement isEqualToString:@"name"]){
		[currentName appendString:string];
	} else if ([currentElement isEqualToString:@"city"]) {
		[currentCity appendString:string];
	}
    else if ([currentElement isEqualToString:@"postcode"]) {
		[currentPostcode appendString:string];
	}
    else if ([currentElement isEqualToString:@"address"]) {
		[currentAddress appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	[self.tableView reloadData];
}


@end

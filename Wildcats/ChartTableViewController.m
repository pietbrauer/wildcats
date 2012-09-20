//
//  ChartTableViewController.m
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "ChartTableViewController.h"
#import "ChartDetailTableViewController.h"
#import "ChartDetailView.h"
#import "FlurryAnalytics.h"


@implementation ChartTableViewController

@synthesize chartCell;
@synthesize chartDetailView;




#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(30, 0, 320, 410);
    UIColor *navColor = [UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1];
	self.navigationController.navigationBar.tintColor = navColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadChart:)];
    //make Background (of AppDelegate) visible and TableView Background invisible/clear background color
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [FlurryAnalytics logEvent:@"Chart"];
    if ([posts count] == 0) {
        //XML File URL
        [self loadChart:nil];
	}
    
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
        [[NSBundle mainBundle] loadNibNamed:@"ChartCell" owner:self options:nil];
        cell = chartCell;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //Every second Cell gets gray Background
        UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
        bg.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        
        if ((indexPath.row%2) == 1) {
            cell.backgroundView = bg;
        }
        self.chartCell = nil;
    }
    
    //defin Cell Labels for keys
    UILabel *positionLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *teamLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *dayLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *goalLabel = (UILabel *)[cell viewWithTag:4];
    UILabel *pointLabel = (UILabel *)[cell viewWithTag:5];
    
    //Parsing XML into Labels
    [positionLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"position"]];
    [teamLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"team"]];
    [dayLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"day"]];
    [goalLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"goal"]];
    [pointLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"point"]];
    
    if ([teamLabel.text isEqualToString:@"SV UNION Halle-Neustadt"]) {
        teamLabel.textColor = [UIColor colorWithRed:197/255.0 green:7/255.0 blue:40/255.0 alpha:1];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [posts count]-1) {
        
        return 130;
    } else {
        return 100;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // Navigation logic may go here. Create and push another view controller.
//    ChartDetailTableViewController *detailViewController = [[ChartDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    
//    NSString *stats = [NSString stringWithFormat:@"%@/%@/%@",[[posts objectAtIndex:indexPath.row] objectForKey:@"won"],[[posts objectAtIndex:indexPath.row] objectForKey:@"pendant"],[[posts objectAtIndex:indexPath.row] objectForKey:@"lost"]];
//    
//    [self.navigationController pushViewController:detailViewController animated:YES];
//    
//    
//    [detailViewController setPosition:[[posts objectAtIndex:indexPath.row] objectForKey:@"position"]];
//    [detailViewController setGames:[[posts objectAtIndex:indexPath.row] objectForKey:@"day"]];
//    [detailViewController setStats:stats];
//    [detailViewController setGoals:[[posts objectAtIndex:indexPath.row] objectForKey:@"goal"]];
//    [detailViewController setTeam:[[posts objectAtIndex:indexPath.row] objectForKey:@"team"]];
//    
//    if ([[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"] substringFromIndex:[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"]length]-2] intValue] == 0)  {
//        [detailViewController setPoints:[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"] substringToIndex:[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"]length]-1]];
//    }else{
//        [detailViewController setPoints:[[posts objectAtIndex:indexPath.row] objectForKey:@"point"]];
//    }
//    
//    NSString *team = [[[posts objectAtIndex:indexPath.row] objectForKey:@"team"] 
//                      substringWithRange:NSMakeRange(0, [[[posts objectAtIndex:indexPath.row] 
//                                                          objectForKey:@"team"] length]-1)];
//    
//    //Zwickau
//    if ([team isEqualToString:@"BSV Sachsen Zwickau"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/BSV_Sachsen_Zwickau.png"]];
//    } 
//    //Dortmund
//    if ([team isEqualToString:@"BVB Dortmund Handball"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/BVB_Dortmund_Handball.png"]];
//    } 
//    //Bensheim/Auerbach
//    if ([team isEqualToString:@"SG Bensheim/Auerbach"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/HSG_Bensheim_Auerbach.png"]];
//    } 
//    //Altlandsberg
//    if ([team isEqualToString:@"MTV 1860 Altlandsberg"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/MTV_Altlandsberg.png"]];
//    } 
//    //Greven
//    if ([team isEqualToString:@"SC Greven 09"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/SC_Greven_09.png"]];
//    } 
//    //Bietigheim
//    if ([team isEqualToString:@"SG BBM Bietigheim"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/SG_BBM_Bietigheim.png"]];
//    } 
//    //Rosengarten-Buchholz
//    if ([team isEqualToString:@"SGH Rosengarten-Buchholz"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/SGH_Rosengarten-Buchholz.png"]];
//    } 
//    //Halle
//    if ([team isEqualToString:@"SV UNION Halle-Neustadt"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/SV_UNION_Halle-Neustadt.png"]];
//    } 
//    //Ketsch
//    if ([team isEqualToString:@"TSG Ketsch"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Ketsch.png"]];
//    } 
//    //Wismar
//    if ([team isEqualToString:@"TSG Wismar"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Wismar.png"]];
//    }
//    //Harrislee
//    if ([team isEqualToString:@"TSV Nord Harrislee"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Nord_Harrislee.png"]];
//    }
//    //Travemünde
//    if ([team isEqualToString:@"TSV Travemünde"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Travemünde.png"]];
//    }
//    //Metzingen
//    if ([team isEqualToString:@"TuS Metzingen"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Metzingen.png"]];
//    }
//    //Weibern
//    if ([team isEqualToString:@"TuS Weibern 1920 e.V."]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Weibern.png"]];
//    }
//    //Nellingen
//    if ([team isEqualToString:@"TV Nellingen"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/TV_Nellingen.png"]];
//    }
//    //Wolfsburg
//    if ([team isEqualToString:@"VFL Wolfsburg"]) {
//        [detailViewController setImage:[UIImage imageNamed:@"TeamImages.bundle/VFL_Wolfsburg.png"]];
//    }
    
    ChartDetailView *detailViewController = [[ChartDetailView alloc] initWithNibName:@"ChartDetailView" bundle:nil];
    
    //Passing Arguments Won/Pendant/Lost into String for Stats-Label
    NSString *stats = [NSString stringWithFormat:@"%@/%@/%@",[[posts objectAtIndex:indexPath.row] objectForKey:@"won"],[[posts objectAtIndex:indexPath.row] objectForKey:@"pendant"],[[posts objectAtIndex:indexPath.row] objectForKey:@"lost"]];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController setTitle:[[posts objectAtIndex:indexPath.row] objectForKey:@"team"]];
    //Pass Objects into Labels
    [detailViewController.team setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"team"]];
    [detailViewController.position setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"position"]];
    [detailViewController.goals setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"goal"]];
    [detailViewController.stats setText:stats];
    [detailViewController.games setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"day"]];

    if ([[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"] substringFromIndex:[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"]length]-2] intValue] == 0)  {
        [detailViewController.points setText:[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"] substringToIndex:[[[posts objectAtIndex:indexPath.row] objectForKey:@"point"]length]-1]];
    }else{
        [detailViewController.points setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"point"]];
    }
    
    //Searching for Image of the team    
    //Set Home Team Image
    if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"BSV Sachsen Zwickau"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/BSV_Sachsen_Zwickau.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"BVB Dortmund Handball"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/BVB_Dortmund_Handball.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"HSG Bensheim/Auerbach"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/HSG_Bensheim_Auerbach.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"MTV 1860 Altlandsberg"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/MTV_Altlandsberg.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"SC Greven 09"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/SC_Greven_09.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"SG BBM Bietigheim"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/SG_BBM_Bietigheim.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"SGH Rosengarten-Buchholz"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/SGH_Rosengarten-Buchholz.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"SV UNION Halle-Neustadt"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/SV_UNION_Halle-Neustadt.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"TSG Ketsch"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Ketsch.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"TSG Wismar"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Wismar.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"TSV Nord Harrislee"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Nord_Harrislee.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"TSV Travemünde"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Travemünde.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"TuS Metzingen"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Metzingen.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"TuS Weibern 1920 e.V."]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Weibern.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"TV Nellingen"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/TV_Nellingen.png"]];
    } if ([[[detailViewController.team text] substringWithRange:NSMakeRange(0, [[detailViewController.team text] length]-1)] isEqualToString:@"VFL Wolfsburg"]){
        [detailViewController.imageView setImage:[UIImage imageNamed:@"TeamImages.bundle/VFL_Wolfsburg.png"]];
    }
    [detailViewController.imageView sizeToFit];
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
		currentPosition = [[NSMutableString alloc] init];
        currentTeam = [[NSMutableString alloc] init];
        currentDay = [[NSMutableString alloc] init];
        currentGoal = [[NSMutableString alloc] init];
		currentPoint = [[NSMutableString alloc] init];
        currentWon = [[NSMutableString alloc] init];
        currentLost = [[NSMutableString alloc] init];
        currentPendant = [[NSMutableString alloc] init];
        currentMinus = [[NSMutableString alloc] init];
        currentPlus = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]){
		[item setObject:currentPosition forKey:@"position"];
		[item setObject:currentTeam forKey:@"team"];
        [item setObject:currentDay forKey:@"day"];
        [item setObject:currentGoal forKey:@"goal"];
        [item setObject:currentPoint forKey:@"point"];
        [item setObject:currentWon forKey:@"won"];
        [item setObject:currentLost forKey:@"lost"];
        [item setObject:currentPendant forKey:@"pendant"];
        [item setObject:currentMinus forKey:@"minus"];
        [item setObject:currentPlus forKey:@"plus"];
		
		[posts addObject:[item copy]];       
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([currentElement isEqualToString:@"position"]){
		[currentPosition appendString:string];
	} else if ([currentElement isEqualToString:@"team"]) {
		[currentTeam appendString:string];
	}
    else if ([currentElement isEqualToString:@"day"]) {
		[currentDay appendString:string];
	}
    else if ([currentElement isEqualToString:@"goal"]) {
		[currentGoal appendString:string];
	}
    else if ([currentElement isEqualToString:@"point"]) {
		[currentPoint appendString:string];
	}
    else if ([currentElement isEqualToString:@"won"]) {
		[currentWon appendString:string];
	}
    else if ([currentElement isEqualToString:@"pendant"]) {
		[currentPendant appendString:string];
	}
    else if ([currentElement isEqualToString:@"lost"]) {
		[currentLost appendString:string];
	}
    else if ([currentElement isEqualToString:@"plus"]) {
		[currentPlus appendString:string];
	}
    else if ([currentElement isEqualToString:@"minus"]) {
		[currentMinus appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	[self.tableView reloadData];
}

-(void)loadChart:(id)sender{
    //XML File URL
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *path = @"http://www.union-halle.net/tabelle.xml.php";
    //Start Parsing
    [self parseXMLFileAtURL:path];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end

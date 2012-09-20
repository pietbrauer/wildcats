//
//  ScheduleTableViewController.m
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "ScheduleDetailView.h"
#import "FlurryAnalytics.h"


@implementation ScheduleTableViewController
@synthesize scheduleCell;
@synthesize scheduleDetailView;



#pragma mark - View lifecycle
-(void)viewDidAppear:(BOOL)animated{
    [FlurryAnalytics logEvent:@"Schedule"];
    [super viewDidAppear:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.scheduleCell = nil;
    self.scheduleDetailView = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    if ([posts count] == 0) {
        [self loadSchedule:nil];
	}
    UIColor *navColor = [UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1];
	self.navigationController.navigationBar.tintColor = navColor;
    [self setClearsSelectionOnViewWillAppear:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadSchedule:)];
    [super viewWillAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)loadSchedule:(id)sender{
    //Setting XML URL
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *path = @"http://www.union-halle.net/spielplan.xml.php";
    [self parseXMLFileAtURL:path];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
        [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:self options:nil];
        cell = scheduleCell;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        //Every second Cell gets gray Background
        UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
        bg.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        if ((indexPath.row%2) == 1) {
            cell.backgroundView = bg;
        }
        
        self.scheduleCell = nil;
    }
    
   //Cell Labels
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *homeLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *guestLabel = (UILabel *)[cell viewWithTag:4];
    UILabel *resultLabel = (UILabel *)[cell viewWithTag:5];
    
    NSString *pointsHome = [[[posts objectAtIndex:indexPath.row] objectForKey:@"result"] substringToIndex:2];
    NSString *pointsGuest = [[[posts objectAtIndex:indexPath.row] objectForKey:@"result"] substringFromIndex:3];
    
    //Parsing XML into Labels
    [dateLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"date"]];
    [timeLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"time"]];
    [homeLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"home"]];
    [guestLabel setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"guest"]];
    if ([pointsHome isEqualToString:@"-:"]) {

        [resultLabel setText:@"-   :   -"];
    }else{
        [resultLabel setText:[NSString stringWithFormat:@"%@   :   %@", pointsHome, pointsGuest]];
    }

    if ([homeLabel.text length] == 24) {
        homeLabel.textColor = [UIColor colorWithRed:197/255.0 green:7/255.0 blue:40/255.0 alpha:1];
    } 
    if ([guestLabel.text length] == 24) {
        guestLabel.textColor = [UIColor colorWithRed:197/255.0 green:7/255.0 blue:40/255.0 alpha:1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Change Height for last row to fit with AdImage (20px)
    if (indexPath.row == [posts count]-1) {
        return 144;
    } else {
        return 104;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - XML

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
		currentDate = [[NSMutableString alloc] init];
        currentTime = [[NSMutableString alloc] init];
        currentHome = [[NSMutableString alloc] init];
        currentGuest = [[NSMutableString alloc] init];
		currentResult = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]){
		[item setObject:currentDate forKey:@"date"];
		[item setObject:currentTime forKey:@"time"];
        [item setObject:currentHome forKey:@"home"];
        [item setObject:currentGuest forKey:@"guest"];
        [item setObject:currentResult forKey:@"result"];
		
		[posts addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([currentElement isEqualToString:@"date"]){
		[currentDate appendString:string];
	} else if ([currentElement isEqualToString:@"time"]) {
		[currentTime appendString:string];
	}
    else if ([currentElement isEqualToString:@"home"]) {
		[currentHome appendString:string];
	}
    else if ([currentElement isEqualToString:@"guest"]) {
		[currentGuest appendString:string];
	}
    else if ([currentElement isEqualToString:@"result"]) {
		[currentResult appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	[self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     ScheduleDetailView *detailViewController = [[ScheduleDetailView alloc] initWithNibName:@"ScheduleDetailView" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    //Set the Title of DetailView for HomeTeam
    [detailViewController setTitle:[[posts objectAtIndex:indexPath.row] objectForKey:@"home"]];
    
    //Set label for Home, Guest, Result
    [detailViewController.labelGuest setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"guest"]];
    [detailViewController.labelHome setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"home"]];
    [detailViewController.result setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"result"]];

    if ([[[[posts objectAtIndex:indexPath.row] objectForKey:@"result"] substringFromIndex:[[[posts objectAtIndex:indexPath.row] objectForKey:@"result"]length]-2] intValue] == 0)  {
        [detailViewController.result setText:[[[posts objectAtIndex:indexPath.row] objectForKey:@"result"] substringToIndex:[[[posts objectAtIndex:indexPath.row] objectForKey:@"result"]length]-2]];
    }else{
        [detailViewController.result setText:[[posts objectAtIndex:indexPath.row] objectForKey:@"result"]];
    }
    
    //Set Home Team Image
     if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"BSV Sachsen Zwickau"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/BSV_Sachsen_Zwickau.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"BVB Dortmund Handball"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/BVB_Dortmund_Handball.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"HSG Bensheim Auerbach"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/HSG_Bensheim_Auerbach.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"MTV 1860 Altlandsberg"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/MTV_Altlandsberg.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"SC Greven 09"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/SC_Greven_09.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"SG BBM Bietigheim"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/SG_BBM_Bietigheim.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"SGH Rosengarten-Buchholz"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/SGH_Rosengarten-Buchholz.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"SV UNION Halle-Neustadt"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/SV_UNION_Halle-Neustadt.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"TSG Ketsch"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Ketsch.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"TSG Wismar"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Wismar.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"TSV Nord Harrislee"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Nord_Harrislee.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"TSV Travemünde"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Travemünde.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"TuS Metzingen"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Metzingen.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"TuS Weibern 1920 e.V."]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Weibern.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"TV Nellingen"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/TV_Nellingen.png"]];
    } if ([[[detailViewController.labelHome text] substringWithRange:NSMakeRange(0, [[detailViewController.labelHome text] length]-1)] isEqualToString:[NSString stringWithString:@"VFL Wolfsburg"]]){
        [detailViewController.imageHome setImage:[UIImage imageNamed:@"TeamImages.bundle/VFL_Wolfsburg.png"]];
    }
     
    //set guestTeam Image
    if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"BSV Sachsen Zwickau"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/BSV_Sachsen_Zwickau.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"BVB Dortmund Handball"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/BVB_Dortmund_Handball.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"HSG Bensheim/Auerbach"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/HSG_Bensheim_Auerbach.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"MTV 1860 Altlandsberg"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/MTV_Altlandsberg.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"SC Greven 09"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/SC_Greven_09.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"SG BBM Bietigheim"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/SG_BBM_Bietigheim.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"SGH Rosengarten-Buchholz"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/SGH_Rosengarten-Buchholz.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"SV UNION Halle-Neustadt"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/SV_UNION_Halle-Neustadt.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"TSG Ketsch"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Ketsch.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"TSG Wismar"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/TSG_Wismar.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"TSV Nord Harrislee"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Nord_Harrislee.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"TSV Travemünde"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/TSV_Travemünde.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"TuS Metzingen"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Metzingen.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"TuS Weibern 1920 e.V."]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/TuS_Weibern.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"TV Nellingen"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/TV_Nellingen.png"]];
    } if ([[[detailViewController.labelGuest text] substringWithRange:NSMakeRange(0, [[detailViewController.labelGuest text] length]-1)] isEqualToString:[NSString stringWithString:@"VFL Wolfsburg"]]){
        [detailViewController.imageGuest setImage:[UIImage imageNamed:@"TeamImages.bundle/VFL_Wolfsburg.png"]];
    }
    
    //Adjust images
    [detailViewController.imageHome sizeToFit];
    [detailViewController.imageGuest sizeToFit];
}



@end

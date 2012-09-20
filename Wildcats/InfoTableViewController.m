//
//  InfoTableViewController.m
//  wildcats
//
//  Created by Piet Brauer on 08.01.12.
//  Copyright (c) 2012 nerdish by nature. All rights reserved.
//

#import "InfoTableViewController.h"
#import "FlurryAnalytics.h"


@implementation InfoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self.tableView setBackgroundColor:[UIColor underPageBackgroundColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss:)];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:172/255.0 green:7/255.0 blue:40/255.0 alpha:1]];
    [self.navigationItem setTitle:@"Info"];
    
    sportWerkText =  @"Die SPORTWERK Internet Marketing GmbH ist einer der größten Onlinevermarkter im Sportbereich. Zurzeit vermarktet SPORTWERK über 180 Vereine und Verbände mit einer Gesamtreichweite von mehr als 200 Mio. Seitenaufrufen und 20 Mio. Besuchern monatlich. SPORTWERK übernimmt zudem die Realisierung und komplette technische Betreuung fast aller Sportportale im Netzwerk. Auch Entwicklungen für mobile Endgeräte sowie TV-Portale im Sport gehören zum Leistungsumfang von SPORTWERK. Haben Sie Fragen zu unserem Unternehmen oder Interesse an unseren Leistungen? Dann sprechen Sie uns an!";
    
    pietText = @"Piet Brauer beschäftigt sich seit über 2 Jahren mit der iPhone und iPad Programmierung und hat mehrere Auftragsarbeiten für zufriedene Kunden erledigt und ist offen für neue Aufgaben. Sie haben eine Idee für Ihr Unternehmen? Sie können mir ganz einfach eine E-Mail schreiben. Nutzen Sie dazu einfach den E-Mail Button in der nächsten Zeile.";
}

-(void)dismiss:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        default:
            return 2;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
            //Piet Section
        case 0:{
            switch (indexPath.row) {
                // description
                case 0:
                    cell.textLabel.text =  pietText;
                    
                    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                    cell.textLabel.numberOfLines = ceilf([pietText sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                //mail
                case 1:
                    cell.textLabel.text = @"E-Mail an Piet Brauer";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                    break;
                //website
                case 2:
                    cell.textLabel.text = @"Website besuchen";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                    break;
                default:
                break;
            }
        }
            break;
            
        //Sportwerk Section
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text =  sportWerkText;
                    
                    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                    cell.textLabel.numberOfLines = ceilf([sportWerkText sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height/20.0);
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                    break;
                case 1:
                    cell.textLabel.text = @"E-Mail an Sportwerk";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                    break;
                case 2:
                    cell.textLabel.text = @"Website besuchen";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                    break;
                default:
                    break;
            }
        }
            break;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //calculating and returning Cell Height
    CGSize titleSize;
    
    switch (indexPath.section) {
            //piet section
        case 0:{
            switch (indexPath.row) {
                case 0:
                    titleSize = [pietText sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
                    return titleSize.height+22;
                    break;
                default:
                    return 40;
                    break;
            }
        }
            break;
            //sportwerk section
        case 1:{
            switch (indexPath.row) {
                case 0:
                    titleSize = [sportWerkText sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
                    return titleSize.height+5;
                    break;
                default:
                    return 40;
                    break;
            }
        }
        
            break;
    }
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                //mail Piet
                case 1:
                {
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
                    break;
                //website Piet
                case 2:{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.nerdishbynature.com"]];
                }
                    break;
                default:
                    break;
            }
           
        
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                    //mail
                case 1:{
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
                    break;
                    //open website
                case 2:{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sportwerk.net"]];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
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

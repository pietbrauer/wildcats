//
//  SpaceTableViewController.h
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpaceDetailView;


@interface SpaceTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
    
    IBOutlet UITableView *spaceTableView;
    IBOutlet UITableViewCell *spaceCell;
    
    SpaceDetailView *spaceDetailView;
    
    //XML Standard Parameters
    NSXMLParser *xmlParser;
	NSMutableArray *posts;
	NSMutableDictionary *item;
	NSString *currentElement;
    //XML Special Parameters
	NSMutableString *currentName;
	NSMutableString *currentCity;
    NSMutableString *currentPostcode;
    NSMutableString *currentAddress;
}

-(void)parseXMLFileAtURL:(NSString *)URL;

-(void)loadSpaces:(id)sender;

@property (nonatomic, strong) IBOutlet UITableViewCell *spaceCell;
@property (nonatomic, strong) SpaceDetailView *spaceDetailView;
@end

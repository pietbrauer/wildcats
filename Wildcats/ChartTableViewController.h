//
//  ChartTableViewController.h
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChartDetailView;


@interface ChartTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
    //Table View
    IBOutlet UITableView *chartTableView;
    //Cell
    IBOutlet UITableViewCell *chartCell;
    
    //Detail View
    ChartDetailView *chartDetailView;
    
    //XML Standard Arguments
    NSXMLParser *xmlParser;
	NSMutableArray *posts;
	NSMutableDictionary *item;
	NSString *currentElement;
    
    //XML Arguments
	NSMutableString *currentPosition;
	NSMutableString *currentTeam;
    NSMutableString *currentDay;
    NSMutableString *currentGoal;
    NSMutableString *currentPoint;
    NSMutableString *currentWon;
    NSMutableString *currentPendant;
    NSMutableString *currentLost;
    NSMutableString *currentPlus;
    NSMutableString *currentMinus;
}

-(void)parseXMLFileAtURL:(NSString *)URL;
-(void)loadChart:(id)sender;

@property (nonatomic, strong) IBOutlet UITableViewCell *chartCell;
@property (nonatomic, strong) ChartDetailView *chartDetailView;

@end

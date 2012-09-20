//
//  ScheduleTableViewController.h
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScheduleDetailView;


@interface ScheduleTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
    //TableView, Custom Cell
    IBOutlet UITableView *scheduleTableView;
    IBOutlet UITableViewCell *scheduleCell;
    
    //Detail view
    ScheduleDetailView *scheduleDetailView;
    
    //XML Standard Parameters
    NSXMLParser *xmlParser;
	NSMutableArray *posts;
	NSMutableDictionary *item;
	NSString *currentElement;
    
    //Special Parameters
	NSMutableString *currentDate;
	NSMutableString *currentTime;
    NSMutableString *currentHome;
    NSMutableString *currentGuest;
    NSMutableString *currentResult;
}

-(void)parseXMLFileAtURL:(NSString *)URL;

-(void)loadSchedule:(id)sender;

@property (nonatomic, strong) IBOutlet UITableViewCell *scheduleCell;
@property (nonatomic, strong) ScheduleDetailView *scheduleDetailView;

@end

//
//  NewstickerTableViewController.h
//  Wildcats
//
//  Created by Piet Brauer on 01.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewstickerDetailView;


@interface NewstickerTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate> {
    IBOutlet UITableView *newstickerTableView;
    //IBOutlet UITableViewCell *newsCell;

    NewstickerDetailView *newstickerDetailView;
    //XML Standard Parameters
    NSXMLParser *xmlParser;
	NSMutableArray *posts;
	NSMutableDictionary *item;
	NSString *currentElement;
    
    //XML Special Parameters
	NSMutableString *currentDate;
	NSMutableString *currentHeadline;
    NSMutableString *currentTeaser;
    NSMutableString *currentArticle;
    
    //Strings for Article and Headline
    NSString *article;
    NSString *headline;
}

-(void)parseXMLFileAtURL:(NSString *)URL;
-(void)loadNews:(id)sender;


//@property (nonatomic, retain) IBOutlet UITableViewCell *newsCell;
@property (nonatomic, strong) NewstickerDetailView *newstickerDetailView;
@end

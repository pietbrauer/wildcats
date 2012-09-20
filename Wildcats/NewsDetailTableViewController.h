//
//  NewsDetailTableViewController.h
//  wildcats
//
//  Created by Piet Brauer on 07.01.12.
//  Copyright (c) 2012 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailTableViewController : UITableViewController{
    NSString *headline;
    NSString *text;
}

@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSString *text;

@end

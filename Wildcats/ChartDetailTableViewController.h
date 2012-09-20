//
//  ChartDetailTableViewController.h
//  wildcats
//
//  Created by Piet Brauer on 07.01.12.
//  Copyright (c) 2012 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartDetailTableViewController : UITableViewController{

    NSString *position;
    UIImage *image;
    NSString *games;
    NSString *stats;
    NSString *goals;
    NSString *points;
    NSString *team;
}

@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *games;
@property (nonatomic, strong) NSString *stats;
@property (nonatomic, strong) NSString *goals;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *team;
@property (nonatomic, strong) UIImage *image;

@end

//
//  ScheduleDetailView.h
//  Wildcats
//
//  Created by Piet Brauer on 25.05.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChartDetailView : UIViewController {
    //Labels for displaying passed Arguments
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *position;
    IBOutlet UILabel *games;
    IBOutlet UILabel *stats;
    IBOutlet UILabel *goals;
    IBOutlet UILabel *points;
    IBOutlet UILabel *team;    
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *position;
@property (nonatomic, strong) UILabel *games;
@property (nonatomic, strong) UILabel *stats;
@property (nonatomic, strong) UILabel *goals;
@property (nonatomic, strong) UILabel *points;
@property (nonatomic, strong) UILabel *team;

@end

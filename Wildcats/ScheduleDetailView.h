//
//  ScheduleDetailView.h
//  Wildcats
//
//  Created by Piet Brauer on 25.05.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScheduleDetailView : UIViewController {
    IBOutlet UIImageView *imageHome;
    IBOutlet UIImageView *imageGuest;
    IBOutlet UILabel *labelHome;
    IBOutlet UILabel *labelGuest;
    IBOutlet UILabel *result;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageHome;
@property (nonatomic, strong) IBOutlet UIImageView *imageGuest;
@property (nonatomic, strong) IBOutlet UILabel *labelHome;
@property (nonatomic, strong) IBOutlet UILabel *labelGuest;
@property (nonatomic, strong) IBOutlet UILabel *result;

@end

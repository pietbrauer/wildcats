//
//  NewsTickerDetailView.h
//  Wildcats
//
//  Created by Piet Brauer on 06.04.11.
//  Copyright 2011 GRAVIS Computervertriebsgesellschaft mbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsTickerDetailView : UIViewController {
    //setiing up textView and HeadlineLabel
    IBOutlet UITextView *articleTexView;
    IBOutlet UILabel *headlineLabel;
}

@property (nonatomic, retain) IBOutlet UITextView *articleTexView;
@property (nonatomic, retain) IBOutlet UILabel *headlineLabel;

@end

//
//  LivetickerViewController.h
//  wildcats
//
//  Created by Piet Brauer on 08.01.12.
//  Copyright (c) 2012 nerdish by nature. All rights reserved.
//



@interface LivetickerViewController : UIViewController {
    IBOutlet UIWebView *webView;
}

@property (nonatomic, strong) UIWebView *webView;

-(void)refreshWebView:(id)sender;

@end

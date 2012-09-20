//
//  BrowserViewController.h
//  wildcats
//
//  Created by Piet Brauer on 20.09.12.
//
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController <UIWebViewDelegate>

-(id)initWithURL:(NSURL *)initURL;
-(id)initWithScript:(NSString *)initScript andTitle:(NSString *)name;

@end

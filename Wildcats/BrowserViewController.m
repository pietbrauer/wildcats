//
//  BrowserViewController.m
//  wildcats
//
//  Created by Piet Brauer on 20.09.12.
//
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, strong) IBOutlet UIWebView *browserWebView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BrowserViewController
@synthesize url;
@synthesize htmlString;
@synthesize browserWebView;
@synthesize timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithURL:(NSURL *)initURL{
    self = [super initWithNibName:@"BrowserViewController" bundle:nil];
    if (self) {
        self.url = initURL;
    }
    
    return self;
}

-(id)initWithScript:(NSString *)initScript andTitle:(NSString *)name;{
    self = [super initWithNibName:@"BrowserViewController" bundle:nil];
    if (self) {
        self.htmlString = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width, minimum-scale=1.0, maximum-scale=2.0\"><meta name=\"apple-mobile-web-app-capable\" content=\"YES\"></head><body>%@</body></html>",initScript];
        
        self.title = name;
    }
    
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadRequest];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(loadRequest) userInfo:0 repeats:YES];
}

-(void)loadRequest{
    NSLog(@"loadRequest");
    if (self.url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        [self.browserWebView loadRequest:request];
    } else{
        [self.browserWebView loadHTMLString:self.htmlString baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (![request.URL isEqual:[NSURL URLWithString:@"about:blank"]]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
        
    }
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

@end

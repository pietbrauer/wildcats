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
@property (nonatomic, strong) IBOutlet UIWebView *browserWebView;

@end

@implementation BrowserViewController
@synthesize url;
@synthesize browserWebView;

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

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.browserWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

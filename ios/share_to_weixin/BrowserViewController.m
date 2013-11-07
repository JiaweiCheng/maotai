//
//  BrowserViewController.m
//  ShareToWeiXin
//
//  Created by xiajin on 11/6/13.
//
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end


@implementation BrowserViewController
@synthesize webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void) openBrowser:(UIView *)parentView webUrl:(NSString *) url
{
    [parentView addSubview:self.view];
    
    //创建URL
    NSURL* webUrl = [NSURL URLWithString:url];
    //创建NSURLRequest
    NSURLRequest* request = [NSURLRequest requestWithURL:webUrl];
    //加载
    [webView loadRequest:request];
}

- (IBAction)closeBrowser
{
    [self.view removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [webView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [webView release];
    webView = nil;
    [super viewDidUnload];
}

@end

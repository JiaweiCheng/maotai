//
//  BrowserViewController.h
//  ShareToWeiXin
//
//  Created by xiajin on 11/6/13.
//
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController
{
    IBOutlet UIWebView *webView;
}

@property (nonatomic, strong) UIWebView *webView;

- (void) openBrowser:(UIView *) parentView webUrl:(NSString *) url;
- (IBAction)closeBrowser;

@end

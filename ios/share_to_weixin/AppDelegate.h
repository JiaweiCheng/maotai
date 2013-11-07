//
//  AppDelegate.h
//  ShareToWeiXin
//
//  Created by xiajin on 11/6/13.
//
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder<UIApplicationDelegate, sendMsgToWeChatViewDelegate,
UIAlertViewDelegate, WXApiDelegate>
{
    enum WXScene _scene;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *viewController;

@end

//  ShareToWeiXin
//
//  Created by xiajin on 11/6/13.
//
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "BrowserViewController.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) changeScene:(NSInteger)scene;
- (void) sendLinkContent:(NSDictionary *)msgDict;
@end


@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *selectTableView;
    IBOutlet UIBarItem *rightButton;
    
	NSMutableDictionary *deleteDic;
}
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate,NSObject> delegate;
@property (nonatomic, strong) UITableView *selectTableView;

@property (nonatomic, retain) NSMutableDictionary *deleteDic;
@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *imageList;

@property (nonatomic, retain) UIBarItem *rightButton;

@property (strong, nonatomic) BrowserViewController *browserViewController;

- (IBAction)chooseData;

@end

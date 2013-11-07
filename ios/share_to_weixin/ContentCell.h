//  ShareToWeiXin
//
//  Created by xiajin on 11/6/13.
//
//

#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *link;
@property (copy, nonatomic) NSString *imgUrl;
@property (copy, nonatomic) UIImage *imgView;

@end

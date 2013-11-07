//  ShareToWeiXin
//
//  Created by xiajin on 11/6/13.
//
//

#import "ContentCell.h"

@implementation ContentCell
@synthesize imageView;
@synthesize titleLabel;
@synthesize descLabel;

@synthesize title;
@synthesize desc;
@synthesize link;
@synthesize imgUrl;
@synthesize imgView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImgView:(UIImage *)img
{
    if (![img isEqual:imgView])
    {
        imgView = [img copy];
        self.imageView.image = imgView;
    }
}

-(void)setTitle:(NSString *)t
{
    if (![t isEqualToString:title])
    {
        title = [t copy];
        self.titleLabel.text = title;
    }
}

-(void)setImgUrl:(NSString *)i {
    if (![i isEqualToString:imgUrl])
    {
        imgUrl = [i copy];
    }
}

-(void)setDesc:(NSString *)d
{
    if (![d isEqualToString:desc])
    {
        desc = [d copy];
        self.descLabel.text = desc;
    }
}

-(void)setLink:(NSString *)l
{
    if (![l isEqualToString:link])
    {
        link = [l copy];
    }
}

@end

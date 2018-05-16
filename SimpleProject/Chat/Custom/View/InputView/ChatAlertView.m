//
//  CarMessageCancelView.m
//  leapmotor
//
//  Created by lijj on 2017/2/27.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatAlertView.h"

@interface ChatAlertView()

@property (assign, nonatomic) CGSize imageSize;

@end

@implementation ChatAlertView

- (instancetype)init
{
    if(self = [super init])
    {
        [self defaultStyle];
        self.frame = CGRectMake(0, 0, 112, 112);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self defaultStyle];
    }
    return self;
}


- (void)defaultStyle
{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 1;
    self.layer.cornerRadius = 8;
}

- (void)setTitleText:(NSString *)titleText
{
    self.titleLabel.text = titleText;
    [self updateUI];
    self.imageView.hidden = YES;
    self.titleLabel.hidden = NO;
}

- (void)setTipText:(NSString *)tipText
{
    self.tipLabel.text = tipText;
    [self updateUI];
}


- (void)updateUI
{
    CGSize size =  [_tipLabel.text boundingRectWithSize:CGSizeMake(112, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    if(size.height >=16*2)
    {
        self.tipLabel.font = [UIFont systemFontOfSize:14.0];
        size = [_tipLabel.text boundingRectWithSize:CGSizeMake(112, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    }
    
    self.height = 112 - 16 + size.height;
    
    self.tipLabel.height = size.height;
    self.tipLabel.width = size.width;
    self.tipLabel.centerX = self.width/2;
    self.tipLabel.y = self.height - 18 - size.height;
    
    _imageView.height = self.imageSize.height;
    _imageView.width = self.imageSize.width;
    _imageView.centerX = self.width/2;
    _imageView.centerY = self.height/2 -20;
    
    _titleLabel.height = 48;
    _titleLabel.width = self.width;
    _titleLabel.centerX = self.width/2;
    _titleLabel.centerY = self.height/2 -20;
    
}


- (void)setImage:(UIImage *)image imageSize:(CGSize)imageSize
{
    self.imageView.image = image;
    self.imageSize = imageSize;
    [self updateUI];
    self.imageView.hidden = NO;
    self.titleLabel.hidden = YES;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [self addSubview:_tipLabel];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _tipLabel;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:48];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}


- (UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
    }
    return _imageView;
}


@end

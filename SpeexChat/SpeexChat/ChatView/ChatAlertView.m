//
//  CarMessageCancelView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
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

- (void)hideImageView:(BOOL)show
{
    self.imageView.hidden = show;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.label.text = _title;
    [self updateUI];
}

- (void)setTitleColor:(UIColor *)color
{
    self.label.textColor = color;
}

- (void)updateUI
{
    CGSize size = [_title sizeWithFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(112, MAXFLOAT)];
    if(size.height >=16*2)
    {
        self.label.font = [UIFont systemFontOfSize:14.0];
        size = [_title sizeWithFont:[UIFont systemFontOfSize:14] andMaxSize:CGSizeMake(112, MAXFLOAT)];
    }
    
    self.height = 112 - 16 + size.height;
    
    self.label.height = size.height;
    self.label.width = size.width;
    self.label.centerX = self.width/2;
    self.label.y = self.height - 18 - size.height;

    self.imageView.height = self.imageSize.height;
    self.imageView.width = self.imageSize.width;
    self.imageView.centerX = self.width/2;
    self.imageView.centerY = self.height/2 -20;
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
    self.imageSize = image.size;
    [self updateUI];
    
    
    
}

- (void)setImage:(UIImage *)image imageSize:(CGSize)imageSize
{
    _image = image;
    self.imageView.image = image;
    self.imageSize = imageSize;
    [self updateUI];
}

- (UILabel *)label
{
    if(!_label)
    {
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label;
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

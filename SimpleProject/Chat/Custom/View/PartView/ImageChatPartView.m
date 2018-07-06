//
//  ChatImagePartView.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ImageChatPartView.h"

@implementation ImageChatPartView

- (instancetype)initWithConfig:(ChatViewConfig *)config
{
    if (self = [super initWithConfig:config]) {
        _imageSize = CGSizeMake(160, 90);
    }
    return self;
}

- (void)updateViewByModel:(id<ChatModelProtocol>)model
{
    [super updateViewByModel:model];
    UIImage *image = [UIImage imageWithContentsOfFile:model.filePath];
    [self setPrevImage:image];
    
}

- (void)setPrevImage:(UIImage *)image
{
    if(image)
    {
        CGSize size = image.size;
        self.prevImageView.height = size.height * _imageSize.width /size.width;
        self.prevImageView.image = image;
    }
    self.width = self.prevImageView.width;
    self.height = self.prevImageView.height;
    [self updateViewForSource];
}

- (void)setImageSize:(CGSize)imageSize
{
    _imageSize = imageSize;
    [self updateViewByModel:self.model];
}


- (UIImageView *)prevImageView
{
    if(!_prevImageView)
    {
        _prevImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _imageSize.width, _imageSize.height)];
        [self addSubview:_prevImageView];
    }
    return _prevImageView;
}

@end

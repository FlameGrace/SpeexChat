//
//  VideoChatPartView.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "VideoChatPartView.h"

@implementation VideoChatPartView

- (void)updateViewByModel:(id<ChatModelProtocol>)model
{
    self.model = model;
    [self prevImageView];
    [self playIcon];
    //    NSString *videoPath = [NSFileManager documenFullPath:model.filePath];
    //    [UIImage fastGetLocalVideoFirstFrameImage:videoPath gotImageBlock:^(UIImage *image) {
    //        dispatch_async(dispatch_get_main_queue(),^{
    //            if(image)
    //            {
    //                self.prevImageView.image = image;
    //            }
    //            else
    //            {
    //                self.prevImageView.image = [UIImage imageNamed:@"video_back_ground"];
    //            }
    //        });
    //    }];
    
    
}

- (void)sourceOtherView
{
    [super sourceOtherView];
}

- (void)sourceMeView
{
    [super sourceMeView];
}


- (void)updateViewByImageModel:(id<ChatModelProtocol>)model
{
    self.model = model;
    [self prevImageView];
    [self playIcon];
    //    NSString *videoPath = [NSFileManager documenFullPath:model.filePath];
    //    [UIImage fastGetLocalVideoFirstFrameImage:videoPath gotImageBlock:^(UIImage *image) {
    //        dispatch_async(dispatch_get_main_queue(),^{
    //            if(image)
    //            {
    //                self.prevImageView.image = image;
    //            }
    //            else
    //            {
    //                self.prevImageView.image = [UIImage imageNamed:@"video_back_ground"];
    //            }
    //        });
    //    }];
}





- (UIImageView *)playIcon
{
    if(!_playIcon)
    {
        _playIcon = [[UIImageView alloc]init];
        [self.prevImageView addSubview:_playIcon];
        _playIcon.image = [UIImage imageNamed:@"xcjl_shipin_bofang"];
        _playIcon.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_playIcon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.prevImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_playIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.prevImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_playIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_playIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    }
    return _playIcon;
}

@end

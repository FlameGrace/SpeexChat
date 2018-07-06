//
//  ChatVoicePartView.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "VoiceChatPartView.h"

@implementation VoiceChatPartView

- (instancetype)initWithConfig:(ChatViewConfig *)config
{
    if (self = [super initWithConfig:config]) {
        _maxWidth = Chat_MainScreenWidth - 60 - 80;
    }
    return self;
}


- (void)updateViewByModel:(id<ChatModelProtocol>)model
{
    [super updateViewByModel:model];
    self.timeLabel.text = [NSString stringWithFormat:@"%d”",model.voice_time];
    self.imageView.frame = CGRectMake(10, 6, 28, 28);
    self.timeLabel.frame = CGRectMake(40, 12, 30, 16);
    //没有文字，消息题宽度以语音时长为基准
    int voiceTime = model.voice_time;
    if(voiceTime > 60)
    {
        voiceTime = 60;
    }
    if(voiceTime < 0)
    {
        voiceTime = 0;
    }
    CGFloat width = 80 + (voiceTime/60.0)*(_maxWidth);
    self.frame = CGRectMake(0, 0, width, 40);
    [self updateViewForSource];
    [self updateIsReviewed];
    [self updateVoicePlayUI];
}

- (void)setMaxWidth:(CGFloat)maxWidth
{
    _maxWidth = maxWidth;
    [self updateViewByModel:self.model];
}


- (void)updateVoicePlayUI
{
    if(self.model.isPlaying)
    {
        [self.imageView startAnimating];
    }
    else
    {
        [self.imageView stopAnimating];
    }
}

- (void)sourceOtherView
{
    [super sourceOtherView];
    //更改图片和颜色等
    self.timeLabel.textColor = self.config.otherTextColor;
    self.imageView.animationImages = @[[UIImage imageNamed:@"ic_voice_black_01"],[UIImage imageNamed:@"ic_voice_black_02"],[UIImage imageNamed:@"ic_voice_black_03"]];
    self.imageView.image = [UIImage imageNamed:@"ic_voice_black_03"];
}

- (void)sourceMeView
{
    [super sourceMeView];
    //更改图片和颜色等
    self.timeLabel.textColor = self.config.meTextColor;
    self.imageView.animationImages = @[[UIImage imageNamed:@"ic_voice_white_01"],[UIImage imageNamed:@"ic_voice_white_02"],[UIImage imageNamed:@"ic_voice_white_03"]];
    self.imageView.image = [UIImage imageNamed:@"ic_voice_white_03"];
    
}

- (void)updateIsReviewed
{
    if(self.model.source == ChatSourceOther)
    {
        if(self.model.isReviewd)
        {
            self.imageView.image = [UIImage imageNamed:@"ic_voice_black_03"];
        }
        else
        {
            self.imageView.image = [UIImage imageNamed:@"ic_voice_red"];
        }
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:@"ic_voice_white_03"];
    }
}


- (UILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:self.config.textFontSize];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.animationDuration = 1;
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end

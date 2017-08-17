//
//  CarMessageView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatTableViewCell.h"
#import <objc/runtime.h>
#import "NSDate+Extension.h"
#import "ChatTextView.h"
#import "ChatVoiceView.h"
#import "ChatImageView.h"

@implementation ChatTableViewCell

@synthesize model = _model;

+ (instancetype)cell
{
    return [[self alloc]init];
}

+ (CGRect)boundsForModel:(ChatModel *)model
{
    ChatTableViewCell *cell = [self cell];
    cell.width = MainScreenWidth;
    [cell updateViewByModel:model];
    return cell.frame;
}

- (void)updateViewByModel:(ChatModel *)model
{
    self.model = model;
    [self updateMessageViewByModel:model];
    self.nickLabel.text = [model.nickName stringByAppendingString:@"："];
    [self updateViewForSource];
    [self updateFramesAfterSetMessageView];
}

- (void)updateMessageViewByModel:(ChatModel *)model
{
    //防止因为复用导致的messageView已添加bug
    if(self.messageView)
    {
        [self.messageView removeFromSuperview];
    }
    if(model.type == ChatWord)
    {
        self.messageView = [[ChatTextView alloc]init];
    }
    if(model.type == ChatImage || model.type == ChatVideo)
    {
        self.messageView = [[ChatImageView alloc]init];
    }
    if(model.type == ChatVoice)
    {
        ChatVoiceView *voiceView = [[ChatVoiceView alloc]init];
        self.messageView = voiceView;
    }
    [self addSubview:self.messageView];
    self.messageView.layer.cornerRadius = Chat_CornerRadius;
    self.messageView.layer.masksToBounds = YES;
    [self.messageView updateViewByModel:model];
    
    UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleClickTap:)];
    [self.messageView addGestureRecognizer:clickTap];
}



- (void)handleClickTap:(UITapGestureRecognizer *)tap
{
    //已查看的语音消息需要修改视图
    if(self.model.type == ChatVoice && self.model.source == ChatSourceOther)
    {
        if(!self.model.isReviewd)
        {
            self.model.isReviewd = YES;
            ChatVoiceView *voiceView = (ChatVoiceView *)self.messageView;
            [voiceView updateIsReviewed];
            if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:needSaveModel:)])
            {
                [self.delegate chatView:self needSaveModel:self.model];
            }
        }
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:clickedModel:)])
    {
        [self.delegate chatView:self clickedModel:self.model];
    }
}

//根据MessageView的布局更新其他控件的布局
- (void)updateFramesAfterSetMessageView
{
    
    if(self.model.isShowTimeLine)
    {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.model.timeStamp];
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        if([date isToday])
        {
            [df setDateFormat:@"ah:mm"];
        }
        else if([date isYesterday])
        {
            [df setDateFormat:@"昨天 ah:mm"];
        }
        else
        {
            [df setDateFormat:@"MM-dd ah:mm "];
        }
        self.timeLineLabel.text = [df stringFromDate:date];
        
        self.timeLineLabel.frame = CGRectMake(0, 20, MainScreenWidth, 12);
        if(self.model.source == ChatSourceMe)
        {
            self.nickLabel.frame = CGRectZero;
            self.messageView.y = 20 + 12 + 24;
        }
        else
        {
            self.nickLabel.frame = CGRectMake(Chat_LeftMargin, 20 + 12 + 24 , MainScreenWidth, Chat_NickTextFontSize);
            self.messageView.y = self.nickLabel.y + self.nickLabel.height + 5;
        }
    }
    else
    {
        self.timeLineLabel.frame = CGRectZero;
        if(self.model.source == ChatSourceMe)
        {
            self.nickLabel.frame = CGRectZero;
            self.messageView.y = 20;
        }
        else
        {
            self.nickLabel.frame = CGRectMake(Chat_LeftMargin, 20 , MainScreenWidth, Chat_NickTextFontSize);
            self.messageView.y = self.nickLabel.y + self.nickLabel.height + 5;
        }
    }
    self.sendWaringButton.frame = CGRectMake(self.messageView.x - 40, 0, 35, 35);
    self.sendWaringButton.centerY = self.messageView.centerY;
    self.reSendIndicatorView.center = self.sendWaringButton.center;
    self.height = self.messageView.y + self.messageView.height;
}


- (void)updateViewForSource
{
    if(self.model.source == ChatSourceMe)
    {
        [self sourceMeView];
    }
    if(self.model.source == ChatSourceOther)
    {
        [self sourceOtherView];
    }
}

- (void)sourceMeView
{
    self.nickLabel.frame = CGRectZero;
    self.messageView.x = MainScreenWidth - self.messageView.width - Chat_LeftMargin;
    self.messageView.backgroundColor = Chat_MeBackGroundColor;
    [self sendWaringButton];
    if(self.model.isSendSuccess)
    {
        self.sendWaringButton.hidden = YES;
    }
    else
    {
        self.sendWaringButton.hidden = NO;
    }
}

- (void)sourceOtherView
{
    
    self.messageView.x = Chat_LeftMargin;
    self.messageView.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc
{
    if(self.reSendIndicatorView.isAnimating)
    {
        [self.reSendIndicatorView stopAnimating];
    }
}

- (void)reSend
{
    self.sendWaringButton.hidden = YES;
    [self.reSendIndicatorView startAnimating];
    self.reSendIndicatorView.hidden = NO;
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:needResendModel:)])
    {
        [self.delegate chatView:self needResendModel:self.model];
    }
}

- (UILabel *)nickLabel
{
    if(!_nickLabel)
    {
        _nickLabel = [[UILabel alloc]init];
        [self addSubview:_nickLabel];
        _nickLabel.textColor = Chat_OtherTextColor;
        _nickLabel.font = [UIFont systemFontOfSize:Chat_NickTextFontSize];
        
    }
    return _nickLabel;
}

- (UILabel *)timeLineLabel
{
    if(!_timeLineLabel)
    {
        _timeLineLabel = [[UILabel alloc]init];
        [self addSubview:_timeLineLabel];
        _timeLineLabel.textColor = Chat_OtherTextColor;
        _timeLineLabel.font = [UIFont systemFontOfSize:Chat_NickTextFontSize];
        _timeLineLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLineLabel;
}

- (UIButton *)sendWaringButton
{
    if(!_sendWaringButton)
    {
        _sendWaringButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [self addSubview:_sendWaringButton];
        [_sendWaringButton setTitleColor:Chat_MeBackGroundColor forState:UIControlStateNormal];
        [_sendWaringButton addTarget:self action:@selector(reSend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendWaringButton;
}

-  (UIActivityIndicatorView *)reSendIndicatorView
{
    if(!_reSendIndicatorView)
    {
        _reSendIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 44, 40)];
        [self addSubview:_reSendIndicatorView];
        _reSendIndicatorView.hidden = YES;
    }
    return _reSendIndicatorView;
}

@end

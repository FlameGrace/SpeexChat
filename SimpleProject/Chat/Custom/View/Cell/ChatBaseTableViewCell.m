//
//  NewchatView.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatBaseTableViewCell.h"

@interface ChatBaseTableViewCell()

@property (readwrite,strong,nonatomic) ChatViewConfig *config;

@end

@implementation ChatBaseTableViewCell

@synthesize messageView = _messageView;
@synthesize config = _config;

+ (instancetype)cell
{
    return [[self alloc]initWithConfig:[[ChatViewConfig alloc]init]];
}

+ (CGRect)boundsForModel:(id<ChatModelProtocol>)model
{
    ChatTableViewCell *cell = [self cell];
    CGRect bounds = [UIScreen mainScreen].bounds;
    cell.width = bounds.size.width;
    [cell updateViewByModel:model];
    return cell.frame;
}

- (instancetype)initWithConfig:(ChatViewConfig *)config
{
    if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])])
    {
        self.config = config;
    }
    return self;
}

- (void)updateViewByModel:(id<ChatModelProtocol>)model
{
    self.model = model;
    [self updateMessageViewByModel:model];
    [self updateViewForSource];
    [self updateFramesAfterSetMessageView];
}

- (void)updateMessageViewByModel:(id<ChatModelProtocol>)model
{
    //防止因为复用导致的messageView已添加bug
    if(_messageView)
    {
        [_messageView removeFromSuperview];
    }
    self.messageView.layer.cornerRadius = self.config.cornerRadius;
    self.messageView.layer.masksToBounds = YES;
    [self.messageView updateViewByModel:model];
    
    UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleClickTap:)];
    [self.messageView addGestureRecognizer:clickTap];
}

- (void)handleClickTap:(UITapGestureRecognizer *)tap
{
    [self chatView:self clickedModel:self.model];
}


//根据MessageView的布局更新其他控件的布局
- (void)updateFramesAfterSetMessageView
{
    UIView *timeLineView = [self timeLineLabel];
    if(self.model.isShowTimeLine)
    {
        timeLineView.frame = CGRectZero;
    }
    UIView *nickNameView = [self nickLabel];
    if(self.model.source == ChatSourceMe)
    {
        nickNameView.frame = CGRectZero;
    }
    else
    {
        nickNameView.y += timeLineView.y + timeLineView.height +24;
    }
    self.messageView.y = self.nickLabel.y + self.nickLabel.height + 5;
    
    if(self.model.isShowTimeLine)
    {
        UIView *timeLineView = [self timeLineLabel];
        timeLineView.frame = CGRectMake(0, 20, Chat_MainScreenWidth, self.config.timeLineTextFontSize);
        if(self.model.source == ChatSourceMe)
        {
            self.nickLabel.frame = CGRectZero;
            self.messageView.y = 20 + self.config.timeLineTextFontSize + 24;
        }
        else
        {
            self.nickLabel.frame = CGRectMake(self.config.leftMargin, 20 + self.config.timeLineTextFontSize + 24 , Chat_MainScreenWidth, self.config.nickTextFontSize);
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
            self.nickLabel.frame = CGRectMake(self.config.leftMargin, 20 , Chat_MainScreenWidth, self.config.nickTextFontSize);
            self.messageView.y = self.nickLabel.y + self.nickLabel.height + 5;
        }
    }
    if(!self.model.isSendSuccess)
    {
        UIView *reSendView = [self reSendButton];
        reSendView.frame = CGRectMake(self.messageView.x - 40, 0, 35, 35);
        reSendView.centerY = self.messageView.centerY;
        self.reSendIndicatorView.center = reSendView.center;
    }
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
    self.messageView.x = Chat_MainScreenWidth - self.messageView.width - self.config.leftMargin;
    self.messageView.backgroundColor = self.config.meBackGroundColor;
}

- (void)sourceOtherView
{
    self.messageView.x = self.config.leftMargin;
    self.messageView.backgroundColor = [UIColor whiteColor];
}


- (void)reSend
{
    UIView *reSendView = [self reSendButton];
    reSendView.hidden = YES;
    [self.reSendIndicatorView startAnimating];
    self.reSendIndicatorView.hidden = NO;
    [self chatView:self needResendModel:self.model];
}

- (UILabel *)timeLineLabel
{
    if(!_timeLineLabel)
    {
        _timeLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, Chat_MainScreenWidth, self.config.timeLineTextFontSize)];
        [self addSubview:_timeLineLabel];
        _timeLineLabel.textColor = self.config.timeLineTextColor;
        _timeLineLabel.font = [UIFont systemFontOfSize:self.config.timeLineTextFontSize];
        _timeLineLabel.textAlignment = NSTextAlignmentCenter;
        _timeLineLabel.text = [self.model timeLineDescription];
    }
    return _timeLineLabel;
}

- (UIButton *)reSendButton
{
    if(!_reSendButton)
    {
        _reSendButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [self addSubview:_reSendButton];
        _reSendButton.frame = CGRectMake(0, 0, 35, 35);
        [_reSendButton addTarget:self action:@selector(reSend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reSendButton;
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

- (UILabel *)nickLabel
{
    if(!_nickLabel)
    {
        _nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.config.leftMargin, 20 , Chat_MainScreenWidth, self.config.nickTextFontSize)];
        [self addSubview:_nickLabel];
        _nickLabel.textColor = self.config.nickTextColor;
        _nickLabel.font = [UIFont systemFontOfSize:self.config.nickTextFontSize];
        _nickLabel.text = [self.model.person.nickName stringByAppendingString:@"："];
    }
    return _nickLabel;
}


- (ChatViewConfig *)config
{
    if(!_config)
    {
        _config = [[ChatViewConfig alloc]init];
    }
    return _config;
}
@end

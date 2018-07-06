//
//  ChatTableViewCell.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatTableViewCell.h"
#import "ChatPartView.h"

@interface ChatBaseTableViewCell : ChatTableViewCell

@property (readonly,strong,nonatomic) ChatViewConfig *config;
@property (strong, nonatomic) ChatPartView *messageView;
//时间轴，距上一条消息超过10分钟，则显示
@property (strong, nonatomic) UILabel *timeLineLabel;
//昵称栏，默认别人发的消息显示，自己发的消息不显示
@property (strong, nonatomic) UILabel *nickLabel;
//发送失败按钮
@property (strong, nonatomic) UIButton *reSendButton;
//重新发送中的旋转按钮
@property (strong, nonatomic) UIActivityIndicatorView *reSendIndicatorView;

//根据MessageView的布局更新其他控件的布局
- (void)updateFramesAfterSetMessageView;

- (instancetype)initWithConfig:(ChatViewConfig *)config;

@end

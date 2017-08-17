//
//  CarMessageView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//  语音聊天基础Cell，定义共有视图元素和方法

#import <UIKit/UIKit.h>
#import "ChatViewProtocol.h"
#import "ChatPartView.h"



@interface ChatTableViewCell : UITableViewCell <ChatViewProtocol>


@property (weak, nonatomic) id<ChatViewDelegate>delegate;

//时间轴，距上一条消息超过10分钟，则显示
@property (strong, nonatomic) UILabel *timeLineLabel;
//昵称栏，默认别人发的消息显示，自己发的消息不显示
@property (strong, nonatomic) UILabel *nickLabel;
//自定义消息体视图
@property (strong, nonatomic) ChatPartView *messageView;
//发送失败按钮
@property (strong, nonatomic) UIButton *sendWaringButton;
//重新发送中的旋转按钮
@property (strong, nonatomic) UIActivityIndicatorView *reSendIndicatorView;
//重新加载的回调
@property (copy, nonatomic) VoidBlock reloadBlock;

+ (instancetype)cell;

//根据消息获取对应视图大小
+ (CGRect)boundsForModel:(ChatModel *)model;

@end

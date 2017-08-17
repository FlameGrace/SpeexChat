//
//  ChatView_NoReadNumber.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// 聊天页面扩展，显示未读消息计数，点击未读消息计数button滑动到底部

#import "ChatView.h"

@interface ChatView_NoReadNumber : ChatView

@property (strong, nonatomic) UIButton *noReadNumberButton;
@property (strong, nonatomic) NSMutableArray *noReadIndexPaths;

@end

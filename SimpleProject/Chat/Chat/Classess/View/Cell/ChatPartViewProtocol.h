//
//  ChatPartViewProtocol.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatModelProtocol.h"

@protocol ChatPartViewProtocol <NSObject>
//聊天消息
@property (weak, nonatomic) id<ChatModelProtocol>model;
//根据消息更新视图
- (void)updateViewByModel:(id<ChatModelProtocol>)model;
//根据source更新视图
- (void)updateViewForSource;
//设置来源为自己时的视图
- (void)sourceMeView;
//设置来源为其他人时的视图
- (void)sourceOtherView;


@end

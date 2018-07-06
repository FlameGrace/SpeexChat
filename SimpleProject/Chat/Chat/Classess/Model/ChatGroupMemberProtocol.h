//
//  ChatGroupMemberProtocol.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
// 群组成员包含定义

#import <Foundation/Foundation.h>
#import "ChatGroupModelProtocol.h"
#import "ChatPersonModelProtocol.h"

@protocol ChatGroupMemberProtocol <NSObject>

//聊天对象
@property (nonatomic, strong) id <ChatPersonModelProtocol> person;

//聊天组
@property (nonatomic, strong) id <ChatGroupModelProtocol> group;



@end

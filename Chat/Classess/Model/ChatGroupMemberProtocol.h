//
//  ChatGroupMemberProtocol.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
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

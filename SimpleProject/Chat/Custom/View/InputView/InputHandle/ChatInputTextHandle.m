//
//  ChatInputTextHandle.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatInputTextHandle.h"

@implementation ChatInputTextHandle

- (ChatType)inputType
{
    return ChatWord;
}

- (void)inputNewTextMessage:(NSString *)message
{
    if(!message||message.length<1)
    {
        return;
    }
    id <ChatModelProtocol> model = [self creatAnNewChatModel];
    model.message = message;
    [self chatInputHandle:self inputAnNewChatMessage:model];
}

@end

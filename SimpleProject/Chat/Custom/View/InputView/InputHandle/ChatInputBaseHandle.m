//
//  ChatInputHandle.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatInputBaseHandle.h"

@interface ChatInputBaseHandle()

@property (readwrite, strong, nonatomic) Class chatModelClass;
@property (readwrite, strong, nonatomic) id <ChatGroupModelProtocol> group;

@end

@implementation ChatInputBaseHandle
@synthesize delegate = _delegate;

- (instancetype)initWithChatModelClass:(Class <ChatModelProtocol>)chatModelClass group:(id <ChatGroupModelProtocol>)group
{
    if(self = [super init])
    {
        self.chatModelClass = chatModelClass;
        self.group = group;
    }
    return self;
}

- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle inputAnNewChatMessage:(id<ChatModelProtocol>)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandle:inputAnNewChatMessage:)])
    {
        [self.delegate chatInputHandle:handle inputAnNewChatMessage:model];
    }
}

- (BOOL)chatInputHandleCanStartInput:(id<ChatInputHandleProtocol>)handle
{
    BOOL can = YES;
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandleCanStartInput:)])
    {
        can = [self.delegate chatInputHandleCanStartInput:handle];
    }
    return can;
}

- (ChatType)inputType
{
    return ChatWord;
}

- (id<ChatModelProtocol>)creatAnNewChatModel
{
    if(!self.chatModelClass)
    {
        return nil;
    }
    id <ChatModelProtocol> model = [[self.chatModelClass alloc]init];
    model.source = ChatSourceMe;
    model.group = self.group;
    model.type = [self inputType];
    model.accountID = self.group.accountID;
    model.timeStamp = [[NSDate date] timeIntervalSince1970];
    return model;
}

@end

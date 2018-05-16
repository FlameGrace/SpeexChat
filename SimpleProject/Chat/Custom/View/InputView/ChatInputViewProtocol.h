//
//  ChatInputViewProtocol.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/24.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatViewConfig.h"
#import "ChatInputHandleProtocol.h"

@protocol ChatInputViewDelegate <ChatInputHandleDelegate>
@optional
- (void)chatInputHandleSwitched:(id<ChatInputHandleProtocol>)handle;
- (BOOL)chatInputHandleCanStartInput:(id<ChatInputHandleProtocol>)handle;
- (void)chatInputHandleStartInput:(id<ChatInputHandleProtocol>)handle;
- (void)chatInputHandleEndInput:(id<ChatInputHandleProtocol>)handle;

@end

@protocol ChatInputViewProtocol <ChatInputHandleProtocol>

@property (weak, nonatomic) id <ChatInputViewDelegate> delegate;
@property (assign, nonatomic) ChatType inputType;

- (instancetype)initWithChatModelClass:(Class <ChatModelProtocol>)chatModelClass group:(id <ChatGroupModelProtocol>)group config:(ChatViewConfig *)config;

@end



//
//  ChatInputHandleProtocol.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatModelProtocol.h"
#import "ChatGroupModelProtocol.h"

@protocol ChatInputHandleProtocol;

@protocol ChatInputHandleDelegate <NSObject>

- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle inputAnNewChatMessage:(id <ChatModelProtocol> )model;
@optional
- (BOOL)chatInputHandleCanStartInput:(id<ChatInputHandleProtocol>)handle;


@end

@protocol ChatInputVoiceHandleDelegate <ChatInputHandleDelegate>

@optional
//录音音量等级
- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle recordingVoiceLeverUpdated:(float)lever;
//录音时间更新
- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle recordingDurationUpdated:(NSTimeInterval)duration;
//录音进入倒计时
- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle countDownTimeInterval:(NSTimeInterval)countDown;
//开始语音输入
- (void)chatInputHandleStartRecordVoice:(id<ChatInputHandleProtocol>)handle;
//结束语音输入
- (void)chatInputHandleEndRecordVoice:(id<ChatInputHandleProtocol>)handle timeTooShort:(BOOL)timeTooShort;
//是否提示上滑可以取消发送
- (void)chatInputHandleRecordingVoice:(id<ChatInputHandleProtocol>)handle canCancel:(BOOL)can;

@end


@protocol ChatInputHandleProtocol <NSObject>

@property (weak, nonatomic) id <ChatInputHandleDelegate> delegate;

@property (readonly, strong, nonatomic) Class chatModelClass;

@property (readonly, strong, nonatomic) id <ChatGroupModelProtocol> group;

- (instancetype)initWithChatModelClass:(Class <ChatModelProtocol>)chatModelClass group:(id <ChatGroupModelProtocol>)group;

@end



//
//  ChatInputVoiceHandle.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatInputBaseHandle.h"
#import "OggSpeexManager.h"


typedef NS_ENUM(NSInteger, ChatVoiceInputState)
{
    ChatVoiceInputStateNoInputing =0,//默认状态
    ChatVoiceInputStateInputing, //语音输入中
    ChatVoiceInputStateTooShort, //录音时间过短
    ChatVoiceInputStateCanCancel, //录音松开取消的状态
};



@interface ChatInputVoiceHandle : ChatInputBaseHandle <ChatInputVoiceHandleDelegate>

@property (weak, nonatomic) id <ChatInputVoiceHandleDelegate> delegate;
/**
 是否在录音中
 */
@property (readonly ,assign, nonatomic) BOOL isVoicing;
/**
 是否在倒计时中
 */
@property (readonly ,assign, nonatomic) BOOL isCountingDown;
/**
 是否被取消
 */
@property (readonly ,assign, nonatomic) BOOL isCanceled;
/**
 移动到可以取消的距离
 */
@property (assign, nonatomic) CGFloat cancelMoveDistance;

- (void)handleTouchEventForView:(UIView *)view;
- (void)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

- (void)startRecordVoice;
- (void)stopRecordVoice;
- (void)cancelRecordVoice;

@end

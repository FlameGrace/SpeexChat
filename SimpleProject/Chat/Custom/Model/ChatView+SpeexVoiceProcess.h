//
//  ChatView+SpeexVoiceProcess.h
//  Flame Grace
//
//  Created by lijj on 2017/3/27.
//  Copyright © 2017年 Flame Grace. All rights reserved.
// // 聊天页面扩展，实现语音播放和识别的方法

#import "ChatView.h"

@interface ChatView (SpeexVoiceProcess)

- (void)startPlayVoice:(id<ChatModelProtocol>)model;

@end

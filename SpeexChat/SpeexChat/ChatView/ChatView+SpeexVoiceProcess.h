//
//  ChatView+SpeexVoiceProcess.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// // 聊天页面扩展，实现语音播放和识别的方法

#import "ChatView.h"

@interface ChatView (SpeexVoiceProcess)

- (void)startPlayVoice:(ChatModel *)model;

- (void)recognizeVoice:(ChatModel *)model;

@end

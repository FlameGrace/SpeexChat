//
//  CarMessageInputView.h
//  Flame Grace
//
//  Created by lijj on 2017/2/27.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//  车机语音聊天输入模块，内置文字输入和语音输入

#import <UIKit/UIKit.h>
#import "ChatModel.h"
#import "ChatAlertView.h"
#import "ChatInputViewProtocol.h"
#import "ChatInputTextHandle.h"
#import "ChatInputVoiceHandle.h"
#import "ChatViewConfig.h"

@interface ChatInputView : UIView <ChatInputViewProtocol,ChatInputVoiceHandleDelegate,ChatInputViewDelegate>
//上滑取消录音的提示框
@property (strong, nonatomic) ChatViewConfig *config;
@property (strong, nonatomic) UIView *alertBackView; //在录音时，禁止其他点击事件
@property (strong, nonatomic) ChatAlertView *alertView;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *voiceButton;

- (void)hideAlertView;

- (void)cancelInput;

@end

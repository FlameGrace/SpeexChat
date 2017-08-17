//
//  CarMessageInputView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//  车机语音聊天输入模块，内置文字输入和语音输入

#import <UIKit/UIKit.h>
#import "ChatModel.h"
#import "ChatAlertView.h"

@protocol ChatInputViewDelegate <NSObject>
//发送一个新消息
- (void)inputSendNewMessage:(ChatModel *)message;
@optional
//开始语音输入
- (void)inputStartVoice;
//结束语音输入
- (void)inputEndVoice;
//取消语音输入
- (void)inputCancelVoice;
//输入方式切换
- (void)inputTypeSwitched;


@end


typedef NS_ENUM(NSInteger, ChatInputType)
{
    ChatInputText =0,//文字输入
    ChatInputVoice //语音输入
};


@interface ChatInputView : UIView

@property (weak, nonatomic) id<ChatInputViewDelegate>delegate;
//上滑取消录音的提示框
@property (strong, nonatomic) ChatAlertView *alertView;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *voiceButton;
//标记是否正在输入中
@property (assign, nonatomic) BOOL isInputing;
/**
 是否在录音中
 */
@property (assign, nonatomic) BOOL isVoicing;

/**
 当前输入方式，设置输入方式会自动更改视图
 */
@property (assign, nonatomic) ChatInputType inputType;
//取消语音输入
- (void)cancelVoiceInput;

@end

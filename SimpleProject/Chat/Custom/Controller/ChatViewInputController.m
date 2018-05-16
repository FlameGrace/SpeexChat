//
//  ChatViewController.m
//  Chat
//
//  Created by MAC on 2018/5/11.
//  Copyright © 2018年 leapmotor. All rights reserved.
//

#import "ChatViewInputController.h"
#import "TextChatTableViewCell.h"
#import "ImageChatTableViewCell.h"
#import "VoiceChatTableViewCell.h"
#import "VideoChatTableViewCell.h"
#import "ChatView+SpeexVoiceProcess.h"

@interface ChatViewInputController ()

@end

@implementation ChatViewInputController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self inputView];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [self.inputView hideAlertView];
    [self stopVoiceService];
}

#pragma 输入代理，开始语音输入
- (void)chatInputHandleStartInput:(id<ChatInputHandleProtocol>)handle
{
    [self.chatView scrollToBottomAnimation:NO];
}
- (void)chatInputHandleSwitched:(id<ChatInputHandleProtocol>)handle
{
    [self.chatView scrollToBottomAnimation:NO];
}


#pragma 输入代理，接收到一条输入
- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle inputAnNewChatMessage:(ChatModel *)model
{
    model.source = ChatSourceMe;
    model.isSendSuccess = YES;
    model.group = self.group;
    [self.chatView insertNewModel:model];
}


- (void)stopVoiceService
{
    [[OggSpeexManager shareInstance]stopPlay];
    [[OggSpeexManager shareInstance]cancelRecord];
    [self.inputView hideAlertView];
}


- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    [super applicationDidEnterBackground:notification];
    [self stopVoiceService];
    [self.inputView cancelInput];
}

- (UITableViewCell<ChatTableViewCellProtocol> *)customCellForModel:(id<ChatModelProtocol>)model
{
    UITableViewCell<ChatTableViewCellProtocol> *cell = nil;
    Class  cellClass = [TextChatTableViewCell class];
    if(model.type == ChatVoice)
    {
        cellClass = [VoiceChatTableViewCell class];
    }
    if(model.type == ChatImage)
    {
        cellClass = [ImageChatTableViewCell class];
    }
    if(model.type == ChatVideo)
    {
        cellClass = [VideoChatTableViewCell class];
    }
    cell = [[cellClass alloc]initWithConfig:self.inputConfig];
    return cell;
}


- (void)chatView:(UIView *)view clickedModel:(id<ChatModelProtocol>)model
{
    if(model.type == ChatVoice)
    {
        [self.chatView startPlayVoice:model];
    }
}

- (ChatInputView *)inputView
{
    if(!_inputView)
    {
        _inputView = [[ChatInputView alloc]initWithChatModelClass:[ChatModel class] group:self.group config:self.inputConfig];
        _inputView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_inputView];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.delegate = self;
        [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:_inputView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.chatView  attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:_inputView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view  attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:_inputView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
        [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:_inputView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:52.0]];
    }
    return _inputView;
}


@end

//
//  CarMessageInputView.m
//  leapmotor
//
//  Created by lijj on 2017/2/27.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatInputView.h"
#import "TimeOutHandleCenter.h"
#import "UIView+ClearSystemGestureEffect.h"

@interface ChatInputView() <UITextViewDelegate>

@property (readwrite, strong, nonatomic) Class chatModelClass;
@property (readwrite, strong, nonatomic) id <ChatGroupModelProtocol> group;
@property (strong, nonatomic) ChatInputTextHandle *textHandle;
@property (strong, nonatomic) ChatInputVoiceHandle *voiceHandle;
@property (assign, nonatomic) NSTimeInterval time;
@property (assign, nonatomic) BOOL canInput;
@end


@implementation ChatInputView 
@synthesize delegate = _delegate;
@synthesize inputType = _inputType;

static NSString *hideAlertTimeOutIdentifier = @"hideAlertTimeOutIdentifier";

- (instancetype)initWithChatModelClass:(Class<ChatModelProtocol>)chatModelClass group:(id<ChatGroupModelProtocol>)group
{
    return [self initWithChatModelClass:chatModelClass group:group config:nil];
}

- (instancetype)initWithChatModelClass:(Class <ChatModelProtocol>)chatModelClass group:(id <ChatGroupModelProtocol>)group config:(ChatViewConfig *)config
{
    if(self = [super init])
    {
        self.chatModelClass = chatModelClass;
        self.group = group;
        self.config = config;
        _inputType = ChatWord;
        [self alertView];
        [self btnClickSwitchInput];
    }
    return self;
}

- (instancetype)init
{
    if(self = [super init])
    {
        [self btnClickSwitchInput];
    }
    return self;
}

#pragma touch events

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.inputType == ChatVoice)
    {
        [self.voiceHandle hitTest:point withEvent:event];
    }
    return [super hitTest:point withEvent:event];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.inputType == ChatVoice)
    {
        [self.voiceHandle touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.inputType == ChatVoice)
    {
        [self.voiceHandle touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.inputType == ChatVoice)
    {
        [self.voiceHandle touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.inputType == ChatVoice)
    {
        [self.voiceHandle touchesCancelled:touches withEvent:event];
    }
}

#pragma textView设置
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self chatInputHandleStartInput:self];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(self.textView.text.length >0)
    {
        [self sendButtonAbled];
    }
    else
    {
        [self sendButtonDisabled];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self chatInputHandleEndInput:self];
}

- (void)chatInputHandleRecordingVoice:(id<ChatInputHandleProtocol>)handle canCancel:(BOOL)can
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.voiceButton.backgroundColor = [UIColor lightGrayColor];
        self.voiceButton.text = @"松开手指 结束录音";
        if(!self.voiceHandle.isCountingDown)
        {
            if(can)
            {
                [self.alertView setImage:[UIImage imageNamed:@"pic_cancel"] imageSize:CGSizeMake(64, 44)];
            }
            else
            {
                [self.alertView setImage:[UIImage imageNamed:@"pic_recording"] imageSize:CGSizeMake(75, 45)];
            }
        }
        if(can)
        {
            [self.alertView setTipText:@"松开 取消"];
        }
        else
        {
            [self.alertView setTipText:@"上滑 取消"];
        }
        [self showAlertView];
        
    });
}

- (void)chatInputHandleStartRecordVoice:(id<ChatInputHandleProtocol>)handle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.voiceButton.backgroundColor = [UIColor lightGrayColor];
        self.voiceButton.text = @"松开手指 结束录音";
        [self.alertView setImage:[UIImage imageNamed:@"pic_recording"] imageSize:CGSizeMake(75, 45)];
        [self.alertView setTipText:@"上滑 取消"];
        [self showAlertView];
        [self chatInputHandleStartInput:self];
    });
}

- (void)chatInputHandleEndRecordVoice:(id<ChatInputHandleProtocol>)handle timeTooShort:(BOOL)timeTooShort
{
    if(!timeTooShort)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.voiceButton.backgroundColor = [UIColor whiteColor];
            self.voiceButton.text = @"按住 说话";
            [self hideAlertView];
            [self.alertView setImage:[UIImage imageNamed:@"pic_recording"] imageSize:CGSizeMake(75, 45)];
            [self.alertView setTipText:@"上滑 取消"];
        });
    }
    else
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.voiceButton.backgroundColor = [UIColor whiteColor];
            self.voiceButton.text = @"按住 说话";
            [self.alertView setImage:[UIImage imageNamed:@"ic_caution"] imageSize:CGSizeMake(48, 48)];
            [self.alertView setTipText:@"录音时间过短"];
            [self showAlertView];
            __weak typeof(self) weakSelf = self;
            [[TimeOutHandleCenter defaultCenter]registerHandleWithIdentifier:hideAlertTimeOutIdentifier timeOut:1.5 timeOutCallback:^(TimeoutHandle *handle) {
                [weakSelf hideAlertView];
            }];
        });
    }
    [self chatInputHandleEndInput:self];
}

- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle countDownTimeInterval:(NSTimeInterval)countDown
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.voiceButton.backgroundColor = [UIColor lightGrayColor];
        self.voiceButton.text = @"松开手指 结束录音";
        [self.alertView setTitleText:[NSString stringWithFormat:@"%.0f",countDown]];
        [self showAlertView];
    });
}

- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle inputAnNewChatMessage:(id<ChatModelProtocol>)model
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(chatInputHandle:inputAnNewChatMessage:)])
    {
        [self.delegate chatInputHandle:handle inputAnNewChatMessage:model];
    }
}

- (void)chatInputHandleSwitched:(id<ChatInputHandleProtocol>)handle
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(chatInputHandleSwitched:)])
    {
        [self.delegate chatInputHandleSwitched:handle];
    }
}

- (BOOL)chatInputHandleCanStartInput:(id<ChatInputHandleProtocol>)handle
{
    BOOL can = YES;
    if(self.delegate&&[self.delegate respondsToSelector:@selector(chatInputHandleCanStartInput:)])
    {
        can = [self.delegate chatInputHandleCanStartInput:handle];
    }
    return can;
}

- (void)chatInputHandleStartInput:(id<ChatInputHandleProtocol>)handle
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(chatInputHandleStartInput:)])
    {
        [self.delegate chatInputHandleStartInput:handle];
    }
}
- (void)chatInputHandleEndInput:(id<ChatInputHandleProtocol>)handle
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(chatInputHandleEndInput:)])
    {
        [self.delegate chatInputHandleEndInput:handle];
    }
}

/**
 点击发送按钮，生成文字消息
 */
- (void)btnClickSendMessage
{
    if(!self.textView.text.length)
    {
        return;
    }
    [self.textHandle inputNewTextMessage:[self.textView.text copy]];
    self.textView.text = @"";
    [self sendButtonDisabled];
}



/**
 点击切换输入方式
 */
-(void)btnClickSwitchInput
{
    if(self.inputType == ChatWord)
    {
        self.inputType = ChatVoice;
    }
    else
    {
        self.inputType = ChatWord;
    }
}



- (void)setInputType:(ChatType)inputType
{
    _inputType = inputType;
    [self changeViewForInput];
    [self chatInputHandleSwitched:self];
}


- (void)inputTypeTextStyle
{
    [self.switchButton setImage:[UIImage imageNamed:@"ic_mic"] forState:UIControlStateNormal];
    self.voiceButton.hidden = YES;
    self.textView.hidden = NO;
    if(self.textView.text.length >0)
    {
        [self sendButtonAbled];
    }
    else
    {
        [self sendButtonDisabled];
    }
}

- (void)inputTypeVoiceStyle
{
    [self clearSystemGestureEffect];
    [self.switchButton setImage:[UIImage imageNamed:@"ic_keyboard"] forState:UIControlStateNormal];
    self.voiceButton.hidden = NO;
    self.textView.hidden = YES;
    [self sendButtonDisabled];
}


/**
 根据当前输入方式重新布局
 */
- (void)changeViewForInput
{
    if(self.inputType == ChatWord)
    {
        if(self.voiceHandle.isVoicing)
        {
            [self.voiceHandle stopRecordVoice];
        }
        [self.textView becomeFirstResponder];
        [self inputTypeTextStyle];
        [self hideAlertView];
        
    }
    else
    {
        [self.textView resignFirstResponder];
        [self inputTypeVoiceStyle];
    }
    
}

- (UIButton *)sendButton
{
    if(!_sendButton)
    {
        _sendButton = [[UIButton alloc]init];
        _sendButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_sendButton];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sendButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-8]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sendButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sendButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:57]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sendButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        [_sendButton setTitleColor:self.config.inputSendButtonTextColor forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.layer.cornerRadius = self.config.cornerRadius;
        [_sendButton addTarget:self action:@selector(btnClickSendMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}
/**
 发送按钮不可点击
 */
- (void)sendButtonDisabled
{
    self.sendButton.backgroundColor = self.config.inputSendButtonDisabledBackGroudColor;
    self.sendButton.enabled = NO;
}
/**
 发送按钮可点击
 */
- (void)sendButtonAbled
{
    self.sendButton.backgroundColor = self.config.inputSendButtonBackGroudColor;
    self.sendButton.enabled = YES;
}

- (void)cancelInput
{
    [self hideAlertView];
    if(self.voiceHandle.isVoicing)
    {
        [self.voiceHandle cancelRecordVoice];
        [self.voiceButton resignFirstResponder];
    }
}

- (void)hideAlertView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.alertBackView.superview)
        {
            [self.alertBackView removeFromSuperview];
        }
    });
}

- (void)showAlertView
{
    [[TimeOutHandleCenter defaultCenter]removeHandleByIdentifier:hideAlertTimeOutIdentifier];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.alertBackView];
    });
    
}


- (UIButton *)switchButton
{
    if(!_switchButton)
    {
        _switchButton = [[UIButton alloc]init];
        _switchButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_switchButton];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_switchButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_switchButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_switchButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_switchButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        [_switchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_switchButton addTarget:self action:@selector(btnClickSwitchInput) forControlEvents:UIControlEventTouchUpInside];
        _switchButton.layer.cornerRadius = self.config.cornerRadius;
    }
    return _switchButton;
}

- (UILabel *)voiceButton
{
    if(!_voiceButton)
    {
        _voiceButton = [[UILabel alloc]init];
        _voiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_voiceButton];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_voiceButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.switchButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:8]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_voiceButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sendButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-8]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_voiceButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_voiceButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        [self.voiceHandle handleTouchEventForView:_voiceButton];
        _voiceButton.text = @"按住 说话";
        _voiceButton.textColor = self.config.inputVoiceButtonTextColor;
        _voiceButton.textAlignment = NSTextAlignmentCenter;
        _voiceButton.layer.cornerRadius = self.config.cornerRadius;
        _voiceButton.layer.borderColor = self.config.inputVoiceButtonBorderColor.CGColor;
        _voiceButton.layer.borderWidth = 0.5;
        _voiceButton.layer.masksToBounds = YES;
        _voiceButton.backgroundColor = self.config.inputVoiceButtonBackGroudColor;
    }
    return _voiceButton;
}


- (UITextView *)textView
{
    if(!_textView)
    {
        _textView = [[UITextView alloc]init];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_textView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.switchButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:8]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sendButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-8]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        _textView.delegate = self;
        _textView.layer.cornerRadius = self.config.cornerRadius;
        _textView.layer.borderColor = self.config.inputVoiceButtonBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.font = [UIFont systemFontOfSize:16];
    }
    return _textView;
    
}

- (OggSpeexManager *)speexManager
{
    return [OggSpeexManager shareInstance];
}

- (UIView *)alertBackView
{
    if(!_alertBackView)
    {
        _alertBackView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _alertBackView;
}

- (ChatAlertView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[ChatAlertView alloc]init];
        [_alertView setImage:[UIImage imageNamed:@"pic_recording"] imageSize:CGSizeMake(75, 45)];
         [_alertView setTipText:@"上滑 取消"];
        [self.alertBackView addSubview:_alertView];
        CGRect bounds = [UIScreen mainScreen].bounds;
        _alertView.center = CGPointMake(bounds.size.width/2, bounds.size.height/2);
    }
    return _alertView;
}


- (ChatInputTextHandle *)textHandle
{
    if(!_textHandle)
    {
        _textHandle = [[ChatInputTextHandle alloc]initWithChatModelClass:self.chatModelClass group:self.group];
        _textHandle.delegate = self;
    }
    return _textHandle;
}

- (ChatInputVoiceHandle *)voiceHandle
{
    if(!_voiceHandle)
    {
        _voiceHandle = [[ChatInputVoiceHandle alloc]initWithChatModelClass:self.chatModelClass group:self.group];
        _voiceHandle.delegate = self;
    }
    return _voiceHandle;
}

- (ChatViewConfig *)config
{
    if(!_config)
    {
        _config = [[ChatViewConfig alloc]init];
    }
    return _config;
}

@end

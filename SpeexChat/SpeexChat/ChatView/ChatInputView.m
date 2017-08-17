//
//  CarMessageInputView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatInputView.h"
#import "OggSpeexManager.h"


typedef NS_ENUM(NSInteger, ChatVoiceInputState)
{
    ChatVoiceInputStateNoInputing =0,//默认状态
    ChatVoiceInputStateInputing, //语音输入中
    ChatVoiceInputStateTooShort, //录音时间过短
    ChatVoiceInputStateCanCancel, //录音松开取消的状态
};


@interface ChatInputView() <OggSpeexManagerDelegate,UITextViewDelegate>
//录音时长
@property (assign, nonatomic) NSTimeInterval voice_time;

@property (assign, nonatomic) ChatVoiceInputState voiceInputState;
//是否在倒计时中
@property (assign, nonatomic) BOOL isCountingDown;

@property (assign, nonatomic) CGPoint panStartPoint;
//倒计时
@property (strong, nonatomic) UILabel *countDownLabel;

@end


@implementation ChatInputView 

- (instancetype)init
{
    if(self = [super init])
    {
        [self inputTypeTextStyle];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self inputTypeTextStyle];
    }
    return self;
}

- (void)dealloc
{
    [self.speexManager cancelRecording];
}

#pragma touch 事件



#pragma textView设置

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.isInputing = YES;
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
    self.isInputing = NO;
}

#pragma speexManager代理
/**
 录音文件保存完成，生成语音消息
 */
- (void)speexManager:(OggSpeexManager *)speex didRecordSuccessfulWithFileName:(NSString *)filePath time:(NSTimeInterval)interval
{
    NSLog(@"录音完毕...%@",filePath);
    //录音时间过短
    if(interval<1)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            self.voiceInputState = ChatVoiceInputStateTooShort;
//            [self performSelector:@selector(hidealertView) withObject:nil afterDelay:1];
//            [self performSelector:@selector(alertViewInput) withObject:nil afterDelay:1];
        });
        return;
    }
    
    NSDate *date = [NSDate date];
    ChatModel *model = [[ChatModel alloc]init];
    model.timeStamp = [date timeIntervalSince1970];
    model.type = ChatVoice;
    model.source = ChatSourceMe;
    model.voice_time = (int)interval;
    model.filePath = [NSFileManager chatRelativePath:[filePath lastPathComponent]];
    [self sendNewModel:model];
}
/**
 录音超出最大时间
 */
- (void)speexManagerDidRecordTimeout:(OggSpeexManager *)speex
{
    if(self.isVoicing)
    {
        [self stopVoice];
    }
}
/**
 录音结束
 */
- (void)speexManagerDidStopRecord:(OggSpeexManager *)speex
{
    if(self.isVoicing)
    {
        [self stopVoice];
    }
}
/**
 录音失败
 */
- (void)speexManager:(OggSpeexManager *)speex didRecordFailure:(NSString *)errorDesciption
{
    if(self.isVoicing)
    {
        [self stopVoice];
    }
}
/**
 录音时音量变化
 @param leveeter 音量等级
 */
- (void)speexManager:(OggSpeexManager *)speex recordingLeverMeterUpdated:(float)leveeter
{
    
}

/**
 录音时，录音时间更新，1s更新一次
 @param interval 当前已录音时间
 */
- (void)speexManager:(OggSpeexManager *)speex recordingTimeUpdated:(NSTimeInterval)interval
{
    self.voice_time = interval;
    int time = floor(interval) - 50;
    //启动倒计时
    if(time >= 0)
    {
        dispatch_async(dispatch_get_main_queue(),^{
            
            self.isCountingDown = YES;
            self.countDownLabel.text = [NSString stringWithFormat:@"%d",10-time];
            
        });
        if(time > 10)
        {
            dispatch_async(dispatch_get_main_queue(),^{
                
                [self btnClickStopVoice];
                [self.voiceButton resignFirstResponder];
            });
        }
    }
    
}



/**
 将消息发送给代理
 */
- (void)sendNewModel:(ChatModel *)model
{
    if([self.delegate respondsToSelector:@selector(inputSendNewMessage:)])
    {
        [self.delegate inputSendNewMessage:model];
    }
}
//self.voiceButton监听滑动手势，上滑一定位置取消录音
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    BOOL isCanCancel = NO;
    
    if(panGesture.state == UIGestureRecognizerStateBegan)
    {
        self.panStartPoint = [panGesture locationInView:self.superview];
        return;
    }
    CGPoint newPoint = [panGesture locationInView:self.superview];
    CGFloat moveY = newPoint.y - self.panStartPoint.y;
    
    if(moveY < - MainScreenHeight/5)
    {
        isCanCancel = YES;
    }
    
    if(panGesture.state == UIGestureRecognizerStateChanged)
    {
        if(isCanCancel)
        {
            self.voiceInputState = ChatVoiceInputStateCanCancel;
        }
        else
        {
            self.voiceInputState = ChatVoiceInputStateInputing;
        }
        if(self.voice_time > 59)
        {
            self.voiceInputState = ChatVoiceInputStateNoInputing;
            return;
        }
    }
    if(panGesture.state == UIGestureRecognizerStateEnded)
    {
        if(isCanCancel)
        {
            [self btnClickCancelVoice];
        }
        else
        {
            [self btnClickStopVoice];
        }
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
    
    NSDate *date = [NSDate date];
    ChatModel *model = [[ChatModel alloc]init];
    model.timeStamp = [date timeIntervalSince1970];
    model.type = ChatWord;
    model.source = ChatSourceMe;
    model.voice_time = 0;
    model.message = [self.textView.text copy];
    [self sendNewModel:model];
    self.textView.text = @"";
    [self sendButtonDisabled];
}



/**
 点击切换输入方式
 */
-(void)btnClickSwitchInput
{
    if(self.inputType == ChatInputText)
    {
        self.inputType = ChatInputVoice;
    }
    else
    {
        self.inputType = ChatInputText;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputTypeSwitched)])
    {
        [self.delegate inputTypeSwitched];
    }
    
}
//点击开始语音输入
- (void)btnClickStartVoice
{
    self.isVoicing = YES;
    self.isInputing = YES;
    self.voice_time = 0;
    
    if(self.speexManager.isPlaying)
    {
        [self.speexManager stopPlaying];
    }
    if(self.speexManager.isRecording)
    {
        [self.speexManager stopRecording];
    }
    //结束播放，结束录音后再设置代理，防止其他接收不到消息
    self.speexManager.delegate = self;
    
    NSTimeInterval startTime = [[NSDate date]timeIntervalSince1970];
    
    NSString *relativePath = [NSFileManager chatRelativePath:[NSString stringWithFormat:@"%f.spx",startTime]];
    NSString *savePath = [NSFileManager documenFullPath:relativePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL creatFileSuccessfully = [fileManager createFileAtPath:savePath
                                                      contents:nil
                                                    attributes:nil];
    if (creatFileSuccessfully)
    {
        [self.speexManager startRecordingInFilePath:savePath];
    }
    self.voiceInputState = ChatVoiceInputStateInputing;
    if([self.delegate respondsToSelector:@selector(inputStartVoice)])
    {
        [self.delegate inputStartVoice];
    }
    
}

//取消语音输入
- (void)cancelVoiceInput
{
    [self.speexManager cancelRecording];
    [self stopVoice];
}


- (void)btnClickCancelVoice
{
    
    [self cancelVoiceInput];
    
    if([self.delegate respondsToSelector:@selector(inputCancelVoice)])
    {
        [self.delegate inputCancelVoice];
    }
    
}


//松开按钮，结束语音输入
- (void)btnClickStopVoice
{
    [self.speexManager stopRecording];
    [self stopVoice];
    if([self.delegate respondsToSelector:@selector(inputEndVoice)])
    {
        [self.delegate inputEndVoice];
    }
    
}

//记录录音结束时间，更改视图，发送代理消息
- (void)stopVoice
{
    self.isVoicing = NO;
    self.isInputing = NO;
    self.isCountingDown = NO;
    
    dispatch_async(dispatch_get_main_queue(),^{
        self.voiceInputState = ChatVoiceInputStateNoInputing;
    });
}



- (void)setInputType:(ChatInputType)inputType
{
    _inputType = inputType;
    [self changeViewForInput];
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
    if(self.inputType == ChatInputText)
    {
        if(self.isVoicing)
        {
            [self btnClickStopVoice];
        }
        [self.textView becomeFirstResponder];
        [self inputTypeTextStyle];
        
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
        [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@57);
            make.right.equalTo(self).offset(-8);
            make.centerY.equalTo(self);
        }];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.layer.cornerRadius = 8;
        [_sendButton addTarget:self action:@selector(btnClickSendMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}
/**
 发送按钮不可点击
 */
- (void)sendButtonDisabled
{
    self.sendButton.backgroundColor = [UIColor grayColor];
    self.sendButton.enabled = NO;
}
/**
 发送按钮可点击
 */
- (void)sendButtonAbled
{
    self.sendButton.backgroundColor = [UIColor blueColor];
    self.sendButton.enabled = YES;
}


- (UIButton *)switchButton
{
    if(!_switchButton)
    {
        _switchButton = [[UIButton alloc]init];
        _switchButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_switchButton];
        [_switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            make.left.equalTo(self).offset(8);
            make.centerY.equalTo(self);
        }];
        [_switchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_switchButton addTarget:self action:@selector(btnClickSwitchInput) forControlEvents:UIControlEventTouchUpInside];
        _switchButton.layer.cornerRadius = 8;
    }
    return _switchButton;
}

- (UIButton *)voiceButton
{
    if(!_voiceButton)
    {
        _voiceButton = [[UIButton alloc]init];
        _voiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_voiceButton];
        [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.switchButton.mas_right).offset(8);
            make.right.equalTo(self.sendButton.mas_left).offset(-8);
        }];
        
        [_voiceButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_voiceButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_voiceButton addTarget:self action:@selector(btnClickStartVoice) forControlEvents:UIControlEventTouchDown];
        [_voiceButton addTarget:self action:@selector(btnClickStopVoice) forControlEvents:UIControlEventTouchUpInside];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        [_voiceButton addGestureRecognizer:panGesture];
        _voiceButton.layer.cornerRadius = 8;
        _voiceButton.layer.borderColor = [UIColor grayColor].CGColor;
        _voiceButton.layer.borderWidth = 0.5;
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
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.centerY.equalTo(self);
            make.left.equalTo(self.switchButton.mas_right).offset(8);
            make.right.equalTo(self.sendButton.mas_left).offset(-8);
        }];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 8;
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.font = [UIFont systemFontOfSize:16];
    }
    return _textView;
    
}

- (OggSpeexManager *)speexManager
{
    return [OggSpeexManager shareInstance];
}


- (void)setVoiceInputState:(ChatVoiceInputState)voiceInputState
{
    _voiceInputState = voiceInputState;
    
    dispatch_async(dispatch_get_main_queue(),^{
        if(self.isCountingDown)
        {
            self.countDownLabel.hidden = NO;
            [self.alertView hideImageView:YES];
        }
        else
        {
            self.countDownLabel.hidden = YES;
            [self.alertView hideImageView:NO];
        }
        _voiceButton.backgroundColor = [UIColor whiteColor];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        if(_voiceInputState == ChatVoiceInputStateNoInputing)
        {
            _voiceButton.backgroundColor = [UIColor whiteColor];
            self.alertView.image = [UIImage imageNamed:@"pic_recording"];
            self.alertView.title = @"上滑 取消";
            [self.voiceButton setTitle:@"按住 说话" forState:UIControlStateNormal];
            [self hidealertView];
        }
        if(_voiceInputState == ChatVoiceInputStateInputing)
        {
            self.alertView.image = [UIImage imageNamed:@"pic_recording"];
            self.alertView.title = @"上滑 取消";
            [self.voiceButton setTitle:@"松开 结束" forState:UIControlStateNormal];
            //在录音过短提示过去之后再显示
            [self performSelector:@selector(showalertView) withObject:nil afterDelay:1];
        }
        if(_voiceInputState == ChatVoiceInputStateTooShort)
        {
            self.alertView.image = [UIImage imageNamed:@"ic_caution"];
            self.alertView.title = @"录音时间过短";
            _voiceButton.backgroundColor = [UIColor whiteColor];
            [self.voiceButton setTitle:@"按住 说话" forState:UIControlStateNormal];
            [self showalertView];
            [self performSelector:@selector(hidealertView) withObject:nil afterDelay:1];
        }
        if(_voiceInputState == ChatVoiceInputStateCanCancel)
        {
            self.alertView.image = [UIImage imageNamed:@"pic_cancel"];
            self.alertView.title = @"松开 取消";
            [self.voiceButton setTitle:@"松开手指 结束录音" forState:UIControlStateNormal];
            [self showalertView];
        }
    });
}


- (void)hidealertView
{
    self.alertView.hidden = YES;
    [self.superview sendSubviewToBack:self.alertView];
}

- (void)showalertView
{
    self.alertView.hidden = NO;
    [self.superview bringSubviewToFront:self.alertView];
}

- (ChatAlertView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[ChatAlertView alloc]init];
        [self.superview addSubview:_alertView];
        _alertView.image = [UIImage imageNamed:@"pic_recording"];
        _alertView.title = @"上滑 取消";
        _alertView.center = self.superview.center;
        
        self.countDownLabel = [[UILabel alloc]init];
        self.countDownLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_alertView addSubview:self.countDownLabel];
        [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@48);
            make.centerX.equalTo(_alertView);
            make.centerY.equalTo(_alertView).offset(-20);
        }];
        self.countDownLabel.textColor = [UIColor whiteColor];
        self.countDownLabel.font = [UIFont systemFontOfSize:48];
        self.countDownLabel.hidden = YES;
        self.countDownLabel.textAlignment = NSTextAlignmentCenter;
        _alertView.hidden = YES;
        [self.superview sendSubviewToBack:_alertView];
    }
    return _alertView;
}


@end

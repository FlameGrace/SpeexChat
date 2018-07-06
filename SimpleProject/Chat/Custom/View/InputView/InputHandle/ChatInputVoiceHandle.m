//
//  ChatInputVoiceHandle.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatInputVoiceHandle.h"
#define ChatInputVoice_MaxRecordTime (60)

@interface ChatInputVoiceHandle() <OggSpeexManagerDelegate>
//是否在倒计时中
@property (readwrite,assign, nonatomic) BOOL isCountingDown;
@property (readwrite ,assign, nonatomic) BOOL isVoicing;
@property (readwrite ,assign, nonatomic) BOOL isCanceled;

@property (readwrite,assign, nonatomic) CGPoint touchStartPoint;
@property (assign, nonatomic) NSTimeInterval touchStartTime;

@property (assign, nonatomic) BOOL isTouching;

@property (weak, nonatomic) UIView *handleView;
//SpeexManager
@property (weak, nonatomic) OggSpeexManager *speexManager;

@end

@implementation ChatInputVoiceHandle
@synthesize delegate = _delegate;

- (instancetype)initWithChatModelClass:(Class<ChatModelProtocol>)chatModelClass group:(id<ChatGroupModelProtocol>)group
{
    if(self = [super initWithChatModelClass:chatModelClass group:group])
    {
        CGRect bounds = [UIScreen mainScreen].bounds;
        self.cancelMoveDistance = bounds.size.height/5;
        self.speexManager.maxRecordDuration = ChatInputVoice_MaxRecordTime;
    }
    return self;
}


- (ChatType)inputType
{
    return ChatVoice;
}

- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle recordingVoiceLeverUpdated:(float)lever
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandle:recordingVoiceLeverUpdated:)])
    {
        [self.delegate chatInputHandle:handle recordingVoiceLeverUpdated:lever];
    }
}

- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle countDownTimeInterval:(NSTimeInterval)countDown
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandle:countDownTimeInterval:)])
    {
        [self.delegate chatInputHandle:handle countDownTimeInterval:countDown];
    }
}


- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle recordingDurationUpdated:(NSTimeInterval)duration
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandle:recordingDurationUpdated:)])
    {
        [self.delegate chatInputHandle:handle recordingDurationUpdated:duration];
    }
}

- (void)chatInputHandleStartRecordVoice:(id<ChatInputHandleProtocol>)handle
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandleStartRecordVoice:)])
    {
        [self.delegate chatInputHandleStartRecordVoice:handle];
    }
}

- (void)chatInputHandleEndRecordVoice:(id<ChatInputHandleProtocol>)handle timeTooShort:(BOOL)timeTooShort
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandleEndRecordVoice:timeTooShort:)])
    {
        [self.delegate chatInputHandleEndRecordVoice:handle timeTooShort:timeTooShort];
    }
}

- (void)chatInputHandleRecordingVoice:(id<ChatInputHandleProtocol>)handle canCancel:(BOOL)can
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatInputHandleRecordingVoice:canCancel:)])
    {
        [self.delegate chatInputHandleRecordingVoice:handle canCancel:can];
    }
}



#pragma speexManager代理
/**
 录音文件保存完成，生成语音消息
 */
- (void)oggSpeex:(id)oggSpeex recordNewFile:(NSString *)filePath recordDuration:(NSTimeInterval)duration
{
    [self stopVoice];
    //录音时间过短
    if(duration<1)
    {
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
        return;
    }
    id <ChatModelProtocol> model = [self creatAnNewChatModel];
    model.voice_time = floor(duration);
    model.fileName = [filePath lastPathComponent];
    [self chatInputHandle:self inputAnNewChatMessage:model];
}
/**
 录音超出最大时间
 */
- (void)oggSpeexDidReachMaxRecordDuration:(id)oggSpeex
{
    [self stopVoice];
}

/**
 录音失败
 */
- (void)oggSpeexRecordFailed:(id)oggSpeex
{
    [self stopVoice];
}
/**
 录音时音量变化
 @param level 音量等级
 */
- (void)oggSpeex:(id)oggSpeex recordLevelMeterChanged:(float)level
{
    [self chatInputHandle:self recordingVoiceLeverUpdated:level];
}

- (void)oggSpeexStopedRecord:(id)oggSpeex isCanceled:(BOOL)isCanceled
{
    
}

/**
 录音时，录音时间更新，1s更新一次
 @param duration 当前已录音时间
 */
- (void)oggSpeex:(id)oggSpeex recordDurationChanged:(NSTimeInterval)duration
{
    [self chatInputHandle:self recordingDurationUpdated:duration];
    int time = ChatInputVoice_MaxRecordTime - floor(duration);
    //启动倒计时
    if(time <= 10)
    {
        self.isCountingDown = YES;
        [self.handleView resignFirstResponder];
        [self chatInputHandle:self countDownTimeInterval:time];
    }

}

- (void)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [self touchesBeganInPoint:point];
}

- (void)touchesBeganInPoint:(CGPoint)point
{
    @synchronized (self)
    {
        NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
        if(CGPointEqualToPoint(point, self.touchStartPoint) && time - self.touchStartTime < 1)
        {
            return;
        }
        self.touchStartTime = time;
        if(CGRectContainsPoint(self.handleView.frame, point))
        {
            if(!self.isTouching)
            {
                self.isTouching = YES;
                self.touchStartPoint = point;
                if([self chatInputHandleCanStartInput:self])
                {
                    [self startRecordVoice];
                }
                else
                {
                    self.isTouching = NO;
                }
            }
        }
        else
        {
            self.isTouching = NO;
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint point = [touch  locationInView:self.handleView.superview];
    [self touchesBeganInPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.isTouching)
    {
        UITouch *touch = touches.allObjects.firstObject;
        BOOL canCancel = [self canCancelTouchMoveToPoint:touch];
        [self chatInputHandleRecordingVoice:self canCancel:canCancel];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.isTouching)
    {
        UITouch *touch = touches.allObjects.firstObject;
        BOOL canCancel = [self canCancelTouchMoveToPoint:touch];
        if(canCancel)
        {
            [self cancelRecordVoice];
        }
        else
        {
            [self stopRecordVoice];
        }
    }
    self.isTouching = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.isTouching)
    {
        [self cancelRecordVoice];
    }
    self.isTouching = NO;
}

- (BOOL)canCancelTouchMoveToPoint:(UITouch *)touch
{
    CGPoint newPoint = [touch  locationInView:self.handleView.superview];
    CGFloat moveY = newPoint.y - self.touchStartPoint.y;
    if(moveY < - self.cancelMoveDistance)
    {
        return YES;
    }
    return NO;
}


//点击开始语音输入
- (void)startRecordVoice
{
    
    self.isVoicing = YES;
    self.isCanceled = NO;
    self.isCountingDown = NO;
    [self chatInputHandleStartRecordVoice:self];
    
    self.speexManager.delegate = self;
    NSTimeInterval startTime = [[NSDate date]timeIntervalSince1970];
    NSString *savePath = [self.group.groupFolderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%f.spx",startTime]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL creatFileSuccessfully = [fileManager createFileAtPath:savePath
                                                      contents:nil
                                                    attributes:nil];
    if (creatFileSuccessfully)
    {
        [self.speexManager startRecordInFilePath:savePath];
    }
    
}

//取消语音输入
- (void)cancelRecordVoice
{
    self.isCanceled = YES;
    [self.speexManager cancelRecord];
    [self stopVoice];
}


//松开按钮，结束语音输入
- (void)stopRecordVoice
{
    [self.speexManager stopRecord];
    [self stopVoice];
}
    
    
//记录录音结束时间，更改视图，发送代理消息
- (void)stopVoice
{
    self.isVoicing = NO;
    self.isCountingDown = NO;
    self.isTouching = NO;
    //录音时间过短
    if([self.speexManager recordDuration]<1 && !self.isCanceled)
    {
        [self chatInputHandleEndRecordVoice:self timeTooShort:YES];
        return;
    }
    [self chatInputHandleEndRecordVoice:self timeTooShort:NO];
}

- (void)dealloc
{
    [self.speexManager cancelRecord];
}

- (OggSpeexManager *)speexManager
{
    return [OggSpeexManager shareInstance];
}

- (void)handleTouchEventForView:(UIView *)view
{
    self.handleView = view;
}
@end

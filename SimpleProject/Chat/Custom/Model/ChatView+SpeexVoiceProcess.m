//
//  ChatView+SpeexVoiceProcess.m
//  leapmotor
//
//  Created by lijj on 2017/3/27.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatView+SpeexVoiceProcess.h"
#import "OggSpeexManager.h"

@interface ChatView () <OggSpeexManagerDelegate>

@end


@implementation ChatView (SpeexVoiceProcess)


static id<ChatModelProtocol>playingModel = nil; //记录正在播放语音的model


- (void)startPlayVoice:(id<ChatModelProtocol>)model
{
    if(model.type != ChatVoice)
    {
        return;
    }
    [self startPlay:model];
}

- (void)oggSpeexStartPlay:(id)oggSpeex
{
    playingModel.isPlaying = YES;
    [self reloadCellForModel:playingModel];
}

/**
 播放结束
 */
- (void)oggSpeexStopedPlay:(id)oggSpeex
{
    playingModel.isPlaying = NO;
    [self reloadCellForModel:playingModel];
}
/**
 播放时接近设备，已自动切换听筒模式/扬声器模式
 */
- (void)oggSpeex:(id)oggSpeex proximityDeviceStateChanged:(BOOL)near
{
    
}
//# Play Bug
- (void)startPlay:(id<ChatModelProtocol>)model
{
    BOOL isPlaing = playingModel.isPlaying;
    //无论何种情况都应该先停止录音和播放
    if(self.speexManager.isRecording)
    {
        [self.speexManager stopRecord];
    }
    if(self.speexManager.isPlaying)
    {
        [self.speexManager stopPlay];
    }
    //再次点击停止播放
    if(playingModel && [model isEqual:playingModel]&&isPlaing)
    {
        return;
    }
    playingModel = model;
    self.speexManager.delegate = self;
    [self.speexManager playAudioFile:model.filePath];
}



- (OggSpeexManager *)speexManager
{
    return [OggSpeexManager shareInstance];
}


@end

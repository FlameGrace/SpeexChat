//
//  ChatView+SpeexVoiceProcess.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatView+SpeexVoiceProcess.h"
#import "OggSpeexManager.h"
//#import "SpeexVoiceToText.h"

@interface ChatView () <OggSpeexManagerDelegate>

@end


@implementation ChatView (SpeexVoiceProcess)


static ChatModel *playingModel = nil; //记录正在播放语音的model


- (void)startPlayVoice:(ChatModel *)model
{
    if(model.type != ChatVoice)
    {
        return;
    }
    [self startPlay:model];
}

- (void)recognizeVoice:(ChatModel *)model
{
    if(model.type != ChatVoice)
    {
        return;
    }
    
//    WeakObj(self)
//    [[SpeexVoiceToText shareInstance] speexVoiceToText:[NSFileManager documenFullPath:model.filePath] completeBlock:^(NSString *result, NSError *error)
//     {
//         //防止block被回收
//         StrongObj(self);
//         
//         if(error == nil)
//         {
//             model.isRecogized = YES;
//             model.message = [result copy];
//             [self chatView:self needSaveModel:model];
//         }
//         [self reloadCellForModel:model];
//     }];

    
}


/**
 播放结束
 */
- (void)speexManagerDidStopPlay:(OggSpeexManager *)speex
{
    [self stopPlay];
}
/**
 播放时接近设备，已自动切换听筒模式
 */
- (void)speexManagerDidCloseToDevice:(OggSpeexManager *)speex
{
    
}
/**
 播放时远离设备，已自动切换扬声器模式
 */
- (void)speexManagerDidFarAwayToDevice:(OggSpeexManager *)speex
{
    
}
//# Play Bug
- (void)startPlay:(ChatModel *)model
{
    
    BOOL isPlaing = playingModel.isPlaying;
    //无论何种情况都应该先停止录音和播放
    if(self.speexManager.isRecording)
    {
        [self.speexManager stopRecording];
    }
    if(self.speexManager.isPlaying)
    {
        [self.speexManager stopPlaying];
    }
    //再次点击停止播放
    if(playingModel && [model isEqual:playingModel]&&isPlaing)
    {
        return;
    }
    playingModel = model;
    playingModel.isPlaying = YES;
    self.speexManager.delegate = self;
    [self.speexManager playAudioWithFilePath:[NSFileManager documenFullPath:model.filePath]];
    [self reloadCellForModel:playingModel];
}

- (void)stopPlay
{
    playingModel.isPlaying = NO;
    [self reloadCellForModel:playingModel];
}



- (OggSpeexManager *)speexManager
{
    return [OggSpeexManager shareInstance];
}


@end

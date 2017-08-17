//
//  ChatModel.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel


@synthesize managedObjectID = _managedObjectID;
@synthesize  personId = _personId;
@synthesize  nickName = _nickName;
@synthesize  source = _source;
@synthesize  type = _type;
@synthesize  filePath = _filePath;
@synthesize  message = _message;
@synthesize  timeStamp = _timeStamp;
@synthesize  isSendSuccess = _isSendSuccess;
@synthesize  isReviewd = _isReviewd;
@synthesize  isRecogized = _isRecogized;
@synthesize  voice_time = _voice_time;
@synthesize  isShowTimeLine = _isShowTimeLine;
@synthesize  isPlaying = _isPlaying;

- (instancetype)init
{
    if(self = [super init])
    {
        self.isSendSuccess = YES;
    }
    return self;
}


- (void)copyChatValueForModel:(id<ChatModelProtocol>)model
{
    model.isPlaying = self.isPlaying;
    model.isShowTimeLine = self.isShowTimeLine;
    model.voice_time = self.voice_time;
    model.isRecogized = self.isRecogized;
    model.isReviewd = self.isReviewd;
    model.isSendSuccess = self.isSendSuccess;
    model.timeStamp = self.timeStamp;
    model.message = [self.message copy];
    model.filePath = [self.filePath copy];
    model.type = self.type;
    model.source = self.source;
    model.personId = self.personId;
}

@end

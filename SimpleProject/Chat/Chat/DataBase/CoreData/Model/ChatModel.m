//
//  ChatModel.m
//  Flame Grace
//
//  Created by lijj on 2017/3/24.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

@synthesize managedObjectID = _managedObjectID;
@synthesize group = _group;
@synthesize  person = _person;
@synthesize  source = _source;
@synthesize  type = _type;
@synthesize  fileName = _fileName;
@synthesize  message = _message;
@synthesize  timeStamp = _timeStamp;
@synthesize  isSendSuccess = _isSendSuccess;
@synthesize  isReviewd = _isReviewd;
@synthesize  isRecogized = _isRecogized;
@synthesize  voice_time = _voice_time;
@synthesize  isShowTimeLine = _isShowTimeLine;
@synthesize  isPlaying = _isPlaying;
@synthesize isTextOpen = _isTextOpen;
@synthesize accountID = _accountID;

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
    model.fileName = [self.fileName copy];
    model.type = self.type;
    model.source = self.source;
    model.person = self.person;
    model.group = self.group;
}

- (NSString *)timeLineDescription
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.timeStamp];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    if([date isToday])
    {
        [df setDateFormat:@"ah:mm"];
    }
    else if([date isYesterday])
    {
        [df setDateFormat:@"昨天 ah:mm"];
    }
    else
    {
        [df setDateFormat:@"MM-dd ah:mm "];
    }
    return [df stringFromDate:date];
}

- (NSString *)filePath
{
    if(!_fileName)
    {
        return nil;
    }
    NSString *filePath = [self.group.groupFolderPath stringByAppendingPathComponent:_fileName];
    return filePath;
}


@end

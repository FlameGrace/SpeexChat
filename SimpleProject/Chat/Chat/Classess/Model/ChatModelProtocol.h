//
//  ChatModelProtocol.h
//  SpeexChat
//
//  Created by lijj on 2017/7/25.
//  Copyright © 2017年 leapmotor. All rights reserved.
//  聊天消息定义

#import <Foundation/Foundation.h>
#import "ChatPersonModelProtocol.h"
#import "ChatGroupModelProtocol.h"

//消息类型
typedef NS_ENUM(NSInteger, ChatType)
{
    ChatVoice = 0,
    ChatWord,
    ChatImage,
    ChatVideo,
};


typedef NS_ENUM(NSInteger, ChatSource)
{
    ChatSourceMe = 0,//消息来源为自己
    ChatSourceOther, //消息来源为其他人
};




@protocol ChatModelProtocol <NSObject>

//聊天对象
@property (nonatomic, strong) id <ChatPersonModelProtocol> person;
//聊天群
@property (nonatomic, strong) id <ChatGroupModelProtocol> group;
//账户ID
@property (copy, nonatomic) NSString *accountID;

@property (nonatomic, assign) ChatSource source;

@property (nonatomic, assign) ChatType type;
//消息文件的保存位置
@property (nonatomic, strong) NSString *fileName;
//保存文字消息或语音消息识别后的文字
@property (nonatomic, strong) NSString *message;
//接收消息的时间
@property (nonatomic, assign) NSTimeInterval timeStamp;
//是否发送成功，主要用于自己发送的消息,默认发送成功
@property (assign, nonatomic) BOOL isSendSuccess;
//该消息是否被查看过
@property (assign, nonatomic) BOOL isReviewd;
//该语音消息是否被识别过
@property (assign, nonatomic) BOOL isRecogized;
//语音时间
@property (assign, nonatomic) int voice_time;
//用于聊天模块视图，是否显示时间轴
@property (assign, nonatomic) BOOL isShowTimeLine;
//需求：正在播放时再次点击停止播放，需记录是否在播放，cell会被重用，因此需在这里记录
@property (assign, nonatomic) BOOL isPlaying;
//用于聊天模块视图，文字过长是否是展开或折叠状态
@property (assign, nonatomic) BOOL isTextOpen;


- (void)copyChatValueForModel:(id<ChatModelProtocol>)model;

- (NSString *)timeLineDescription;

- (NSString *)filePath;

@end

//
//  ChatGroupModelProtocol.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
// 聊天单聊/群组定义

#import <Foundation/Foundation.h>
#import "ChatPersonModelProtocol.h"

typedef NS_ENUM(NSInteger, ChatGroupType)
{
    SingleChat = 0,//不是群聊
    GroupChat, //普通群聊
};
//@{RecieveAnNewChatGroupMessageNotificationMessageKey:id<ChatModelProtocol>model}
#define RecieveAnNewChatGroupMessageNotificationMessageKey (@"RecieveAnNewChatGroupMessageNotificationMessageKey")


typedef NS_ENUM(NSInteger,ChatGroupNoReadNumberState )
{
    ChatGroupStopCountNoReadNumber = -999999,
    ChatGroupStartCountNoReadNumber = 0,
};

@protocol ChatGroupModelProtocol <NSObject>

@property (copy, nonatomic) NSString *groupId;
@property (nonatomic, assign) ChatGroupType groupType;
@property (copy, nonatomic) NSString *groupImage;
@property (copy, nonatomic) NSString *groupName;
@property (nonatomic, assign) NSInteger noReadNumber;
@property (nonatomic, strong) NSDate *updateTime;
@property (nonatomic, copy) NSString *accountID;
//聊天群目录
@property (nonatomic, copy) NSString *groupFolderPath;

- (NSString *)removeAllChatGroupMessagesNotificationName;

- (NSString *)recieveAnNewChatGroupMessageNotificationName;

@end

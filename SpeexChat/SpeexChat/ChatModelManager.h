//
//  LMCarAppChatMessageManager.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "CoreDataModelManager.h"
#import "ChatModel.h"
#import "Chat.h"

// userInfor : @{@"message"}
#define RecievedNewChatMessageNotification (@"RecievedNewChatMessageNotification")
#define RecievedNewChatMessageNotificationMessageKey (@"RecievedNewChatMessageNotificationMessageKey")
#define ChatRemovedAllRecordNotification (@"ChatRemovedAllRecordNotification")

@interface ChatModelManager : CoreDataModelManager

//查询PersonId下的所有聊天记录
- (NSMutableArray *)queryByPersonId:(NSString *)personId;

/**
 获取一个昵称下面的所有消息，并根据timeStamp排序，分页查询

 @param personId 昵称
 @param limit 限制条数
 @param offset 偏移量
 */
- (NSMutableArray *)queryByPersonIdSortForTimeStamp:(NSString *)personId limit:(NSInteger)limit offset:(NSInteger)offset;
/**
 获取一个昵称下面的最后一条消息
 
 @param personId 昵称
 */
- (ChatModel *)queryByPersonIdLastMessage:(NSString *)personId;
/**
 获取一个昵称下面的聊天文件消息（图片，视频)
 @param personId 昵称
 */
- (NSMutableArray *)queryChatFilesByPersonId:(NSString *)personId;
/**
 获取一个昵称下面的聊天文件消息（图片，视频），并根据timeStamp排序，分页查询
 
 @param personId 昵称
 @param limit 限制条数
 @param offset 偏移量
 */
- (NSMutableArray *)queryChatFilesByPersonIdSortForTimeStamp:(NSString *)personId limit:(NSInteger)limit offset:(NSInteger)offset;

/**
 删除所有聊天记录

 @param personId 昵称
 */
- (BOOL)removeAllRecordPersonId:(NSString *)personId;

+ (BOOL)removeAllRecordPersonId:(NSString *)personId;


@end

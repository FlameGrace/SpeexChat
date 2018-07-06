//
//  LMCarAppChatMessageManager.h
//  Flame Grace
//
//  Created by lijj on 16/12/17.
//  Copyright © 2016年 Flame Grace. All rights reserved.
//

#import "CoreDataModelManager.h"
#import "ChatPersonModelManager.h"
#import "ChatGroupModelManager.h"
#import "ChatModel.h"
#import "Chat.h"

@interface ChatModelManager : CoreDataModelManager

//查询聊天组ID下的所有聊天记录
- (NSMutableArray *)queryByGroupId:(NSString *)groupId accountID:(NSString *)accountID;

/**
 获取一个昵称下面的所有消息，并根据timeStamp排序，分页查询

 @param groupId 聊天组ID
 @param accountID 账户ID
 @param limit 限制条数
 @param offset 偏移量
 */
- (NSMutableArray *)queryByGroupIdSortForTimeStamp:(NSString *)groupId accountID:(NSString *)accountID limit:(NSInteger)limit offset:(NSInteger)offset;
/**
 获取一个昵称下面的最后一条消息
 
 @param groupId 昵称
 @param accountID 账户ID
 */
- (ChatModel *)queryByGroupIdLastMessage:(NSString *)groupId accountID:(NSString *)accountID;
/**
 获取一个昵称下面的聊天文件消息（图片，视频)
 @param groupId 昵称
 @param accountID 账户ID
 */
- (NSMutableArray *)queryChatFilesByGroupId:(NSString *)groupId accountID:(NSString *)accountID;
/**
 获取一个昵称下面的聊天文件消息（图片，视频），并根据timeStamp排序，分页查询
 
 @param groupId 昵称
 @param accountID 账户ID
 @param limit 限制条数
 @param offset 偏移量
 */
- (NSMutableArray *)queryChatFilesByGroupIdSortForTimeStamp:(NSString *)groupId accountID:(NSString *)accountID limit:(NSInteger)limit offset:(NSInteger)offset;

/**
 删除所有聊天记录

 @param groupId 昵称
 @param accountID 账户ID
 */
- (BOOL)removeAllRecordGroupId:(NSString *)groupId accountID:(NSString *)accountID;

+ (BOOL)removeAllRecordGroupId:(NSString *)groupId accountID:(NSString *)accountID;


@end

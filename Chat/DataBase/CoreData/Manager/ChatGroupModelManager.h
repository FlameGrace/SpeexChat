//
//  ChatGroupModelManager.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "CoreDataModelManager.h"
#import "ChatGroupModel.h"
#import "ChatGroup.h"
#import "ChatGroupMemberModelManager.h"
#import "ChatPersonModelManager.h"

@interface ChatGroupModelManager : CoreDataModelManager

- (void)updateTime:(NSDate *)date toGroup:(ChatGroupModel *)group;

- (void)addMember:(ChatPersonModel *)person toGroup:(ChatGroupModel *)group;

- (NSMutableArray *)queryAllSortByUpateTimeWithAccountID:(NSString *)accountID;

- (ChatGroupModel *)queryByGroupId:(NSString *)groupId accountID:(NSString *)accountID;

+ (ChatGroupModel *)queryByGroupId:(NSString *)groupId accountID:(NSString *)accountID;
//
+ (NSInteger)noReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID;
//
+ (BOOL)startCountNoReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID;
//
+ (BOOL)stopCountNoReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID;
//
+ (BOOL)incrementNoReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID;

@end

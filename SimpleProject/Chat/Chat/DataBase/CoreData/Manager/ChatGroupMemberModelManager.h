//
//  ChatGroupMemberModelManager.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "CoreDataModelManager.h"
#import "ChatGroupMember.h"
#import "ChatGroupMemberModel.h"
#import "ChatPersonModelManager.h"
#import "ChatGroupModelManager.h"

@interface ChatGroupMemberModelManager : CoreDataModelManager

- (BOOL)isExistMember:(ChatGroupMemberModel *)model;

- (NSArray *)queryByGroupId:(NSString *)groupId;

- (BOOL)removeRecordByGroupId:(NSString *)groupId;

+ (NSArray *)queryByGroupId:(NSString *)groupId;

+ (BOOL)removeRecordByGroupId:(NSString *)groupId;

@end

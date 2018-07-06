//
//  ChatGroupModelManager.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatGroupModelManager.h"


@interface ChatGroupModelManager()


@end


@implementation ChatGroupModelManager

- (NSString *)entityName
{
    return @"ChatGroup";
}

- (ChatGroupModel *)getModelFromManagedObject:(ChatGroup *)managedObject
{
    if(!managedObject)return nil;
    ChatGroupModel *model = [[ChatGroupModel alloc]init];
    [self updateModel:model byManagedObject:managedObject];
    model.managedObjectID = managedObject.objectID;
    return model;
}

- (void)updateModel:(ChatGroupModel *)model byManagedObject:(ChatGroup *)managedObject
{
    model.groupId = managedObject.groupId;
    model.groupName = managedObject.groupName;
    model.groupImage = managedObject.groupImage;
    model.noReadNumber = managedObject.noReadNumber.integerValue;
    model.groupType = managedObject.groupType.integerValue;
    model.updateTime = managedObject.updateTime;
    model.accountID = managedObject.accountID;
    return;
}

- (void)updateManagedObject:(ChatGroup *)managedObject byModel:(ChatGroupModel *)model
{
    managedObject.groupId = model.groupId;
    managedObject.groupName = model.groupName;
    managedObject.groupImage = model.groupImage;
    managedObject.accountID = model.accountID;
    managedObject.updateTime = model.updateTime;
    managedObject.groupType = [NSNumber numberWithInteger:model.groupType];
    managedObject.noReadNumber = [NSNumber numberWithInteger:model.noReadNumber];
    return;
}

- (void)updateTime:(NSDate *)date toGroup:(ChatGroupModel *)group
{
    group.updateTime = date;
    [self update:group];
}

- (void)addMember:(ChatPersonModel *)person toGroup:(ChatGroupModel *)group
{
    ChatGroupMemberModel *model = [[ChatGroupMemberModel alloc]init];
    model.group = group;
    model.person = person;
    ChatGroupMemberModelManager *manager = [[ChatGroupMemberModelManager alloc]init];
    if(![manager isExistMember:model])
    {
        [manager createNewManagedObjectByModel:model];
    }
}

- (NSMutableArray *)queryAllSortByUpateTimeWithAccountID:(NSString *)accountID
{
    NSMutableArray *ar = [self queryWithPredicateFormat:@"accountID = %@" value:accountID sortKey:@"updateTime" asc:NO];
    return ar;
}

- (ChatGroupModel *)queryByGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    NSString *format1 = [NSString stringWithFormat:@"accountID = %@ AND ",accountID];
    NSString *format2 = [format1 stringByAppendingString:@"groupId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:groupId limit:1 offset:0];
    return ar.firstObject;
}

+ (ChatGroupModel *)queryByGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    ChatGroupModelManager *manager = [self manager];
    return [manager queryByGroupId:groupId accountID:accountID];
}


+ (NSInteger)noReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    ChatGroupModel *model = [self queryByGroupId:groupId accountID:accountID];
    return model.noReadNumber;
}


+ (BOOL)incrementNoReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    @synchronized (self)
    {
        NSInteger noReadNumber = [self noReadNumberForGroupId:groupId accountID:accountID];
        if(noReadNumber >= ChatGroupStartCountNoReadNumber)
        {
            noReadNumber += 1;
        }
        return [self setNoReadNumber:noReadNumber ForGroupId:groupId accountID:accountID];
    }
}

+ (BOOL)setNoReadNumber:(NSInteger)noReadNumber ForGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    ChatGroupModelManager *manager = [self manager];
    ChatGroupModel *model = [self queryByGroupId:groupId accountID:accountID];
    if(!model)
    {
        model = [[ChatGroupModel alloc]init];
        model.groupId = groupId;
        model.accountID = accountID;
        model.noReadNumber = noReadNumber;
        return [manager createNewManagedObjectByModel:model];
    }
    model.noReadNumber = noReadNumber;
    return [manager update:model];
}

+ (BOOL)startCountNoReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    if([self noReadNumberForGroupId:groupId accountID:accountID]>=0)
    {
        return YES;
    }
    return [self setNoReadNumber:ChatGroupStartCountNoReadNumber ForGroupId:groupId accountID:accountID];
}

+ (BOOL)stopCountNoReadNumberForGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    return [self setNoReadNumber:ChatGroupStopCountNoReadNumber ForGroupId:groupId accountID:accountID];
}

@end

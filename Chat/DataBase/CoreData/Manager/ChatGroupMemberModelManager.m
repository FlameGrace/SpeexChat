//
//  ChatGroupMemberMemberModelManager.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatGroupMemberModelManager.h"

@interface ChatGroupMemberModelManager()

@end


@implementation ChatGroupMemberModelManager

- (NSString *)entityName
{
    return @"ChatGroupMember";
}

- (ChatGroupMemberModel *)getModelFromManagedObject:(ChatGroupMember *)managedObject
{
    if(!managedObject)return nil;
    ChatGroupMemberModel *model = [[ChatGroupMemberModel alloc]init];
    [self updateModel:model byManagedObject:managedObject];
    model.managedObjectID = managedObject.objectID;
    return model;
}

- (void)updateModel:(ChatGroupMemberModel *)model byManagedObject:(ChatGroupMember *)managedObject
{
    ChatPersonModelManager *personManager = [ChatPersonModelManager manager];
    model.person = [personManager queryByPersonId:managedObject.personId accountID:managedObject.accountID];
    model.group = [ChatGroupModelManager queryByGroupId:managedObject.groupId accountID:managedObject.accountID];
    return;
}

- (void)updateManagedObject:(ChatGroupMember *)managedObject byModel:(ChatGroupMemberModel *)model
{
    managedObject.groupId = model.group.groupId;
    managedObject.personId = model.person.personId;
    managedObject.accountID = model.person.accountID;
    return;
}



- (BOOL)isExistMember:(ChatGroupMemberModel *)model
{
    if(!model||!model.group||!model.person)
    {
        return NO;
    }
    NSString *format1 = [NSString stringWithFormat:@"accountID = %@ AND personId = %@ AND ",model.person.accountID,model.person.personId];
    NSString *format2 = [format1 stringByAppendingString:@"groupId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:model.group.groupId];
    if(ar.count > 0)
    {
        return YES;
    }
    return NO;
}

- (NSMutableArray *)queryByGroupId:(NSString *)groupId
{
    if(!groupId)
    {
        return nil;
    }
    NSArray *ar = [self queryWithPredicateFormat:@"groupId = %@" value:groupId];
    return  ar.firstObject;
}

+ (NSMutableArray *)queryByGroupId:(NSString *)groupId
{
    if(!groupId)
    {
        return nil;
    }
    ChatGroupMemberModelManager *modelManager = [ChatGroupMemberModelManager manager];
    return [modelManager queryByGroupId:groupId];
}


- (BOOL)removeRecordByGroupId:(NSString *)groupId
{
    if(!groupId)
    {
        return YES;
    }
    NSMutableArray *members = [self queryByGroupId:groupId];
    for (ChatGroupMemberModel *model in members) {
        [self removeManagedObject:model.managedObjectID];
    }
    return YES;
}


+ (BOOL)removeRecordByGroupId:(NSString *)groupId
{
    if(!groupId)
    {
        return YES;
    }
    ChatGroupMemberModelManager *modelManager = [ChatGroupMemberModelManager manager];
    return [modelManager removeRecordByGroupId:groupId];
}

                    
@end
                    
                    

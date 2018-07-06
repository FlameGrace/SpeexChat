//
//  ChatPersonModelManager.m
//  SpeexChat
//
//  Created by lijj on 2017/7/25.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatPersonModelManager.h"

@implementation ChatPersonModelManager

- (NSString *)entityName
{
    return @"ChatPerson";
}

- (ChatPersonModel *)getModelFromManagedObject:(ChatPerson *)managedObject
{
    if(!managedObject)return nil;
    ChatPersonModel *model = [[ChatPersonModel alloc]init];
    [self updateModel:model byManagedObject:managedObject];
    model.managedObjectID = managedObject.objectID;
    return model;
}

- (void)updateModel:(ChatPersonModel *)model byManagedObject:(ChatPerson *)managedObject
{
    model.accountID = managedObject.accountID;
    model.personId = managedObject.personId;
    model.nickName = managedObject.nickName;
    model.avatarImage = managedObject.avatarImage;
    return;
}

- (void)updateManagedObject:(ChatPerson *)managedObject byModel:(ChatPersonModel *)model
{
    managedObject.personId = model.personId;
    managedObject.accountID = model.accountID;
    managedObject.nickName = model.nickName;
    managedObject.avatarImage = model.avatarImage;
    return;
}


- (ChatPersonModel *)queryByPersonId:(NSString *)personId accountID:(NSString *)accountID
{
    if(!personId||!accountID)
    {
        return nil;
    }
    NSString *format1 = [NSString stringWithFormat:@"accountID = %@ AND ",accountID];
    NSString *format2 = [format1 stringByAppendingString:@"personId = %@"];
    NSArray *ar = [self queryWithPredicateFormat:format2 value:personId];
    return  ar.firstObject;
}

+ (ChatPersonModel *)queryByPersonId:(NSString *)personId accountID:(NSString *)accountID
{
    ChatPersonModelManager *modelManager = [ChatPersonModelManager manager];
    return [modelManager queryByPersonId:personId accountID:accountID];
}


- (BOOL)removeRecordByPersonId:(NSString *)personId accountID:(NSString *)accountID
{
    if(!personId||!accountID)
    {
        return YES;
    }
    ChatPersonModel *model = [self queryByPersonId:personId accountID:accountID];
    if(![self removeManagedObject:model.managedObjectID])
    {
        return NO;
    }
    return YES;
}


+ (BOOL)removeRecordByPersonId:(NSString *)personId accountID:(NSString *)accountID
{
    ChatPersonModelManager *modelManager = [ChatPersonModelManager manager];
    return [modelManager removeRecordByPersonId:personId accountID:accountID];
}

@end

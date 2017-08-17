//
//  ChatPersonModelManager.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
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
    if(!managedObject || !model)return;
    model.personId = managedObject.personId;
    model.nickName = managedObject.nickName;
    model.avatarImage = managedObject.avatarImage;
    model.noReadNumber = managedObject.noReadNumber.integerValue;
    return;
}

- (void)updateManagedObject:(ChatPerson *)managedObject byModel:(ChatPersonModel *)model
{
    if(!managedObject || !model)return;
    managedObject.personId = model.personId;
    managedObject.nickName = model.nickName;
    managedObject.avatarImage = model.avatarImage;
    managedObject.noReadNumber = [NSNumber numberWithInteger:model.noReadNumber];
    return;
}

+ (NSMutableArray *)queryAll
{
    ChatPersonModelManager *modelManager = [ChatPersonModelManager manager];
    return [modelManager queryAll];
}

- (ChatPersonModel *)queryByPersonId:(NSString *)personId
{
    NSArray *ar = [self queryWithPredicateFormat:@"personId = %@" value:personId];
    return  ar.firstObject;
}

+ (ChatPersonModel *)queryByPersonId:(NSString *)personId
{
    ChatPersonModelManager *modelManager = [ChatPersonModelManager manager];
    return [modelManager queryByPersonId:personId];
}


- (BOOL)removeRecordByPersonId:(NSString *)personId
{
    ChatPersonModel *model = [self queryByPersonId:personId];
    if(![self removeManagedObject:model.managedObjectID])
    {
        return NO;
    }
    return YES;
}


+ (BOOL)removeRecordByPersonId:(NSString *)personId
{
    ChatPersonModelManager *modelManager = [ChatPersonModelManager manager];
    return [modelManager removeRecordByPersonId:personId];
}

@end

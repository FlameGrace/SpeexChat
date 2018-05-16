//
//  ChatManager.m
//  leapmotor
//
//  Created by lijj on 16/12/17.
//  Copyright © 2016年 leapmotor. All rights reserved.
//

#import "ChatModelManager.h"

@interface ChatModelManager()

@end

@implementation ChatModelManager

- (NSString *)entityName
{
    return @"Chat";
}

- (ChatModel *)getModelFromManagedObject:(Chat *)managedObject
{
    if(!managedObject)return nil;
    ChatModel *model = [[ChatModel alloc]init];
    [self updateModel:model byManagedObject:managedObject];
    model.managedObjectID = managedObject.objectID;
    return model;
}

- (void)updateModel:(ChatModel *)model byManagedObject:(Chat *)managedObject
{
    model.message = managedObject.message;
    model.fileName = managedObject.fileName;
    model.accountID = managedObject.accountID;
    ChatPersonModelManager *personManager = [ChatPersonModelManager manager];
    model.person = [personManager queryByPersonId:managedObject.personId accountID:managedObject.accountID];
    model.group = [ChatGroupModelManager queryByGroupId:managedObject.groupId accountID:managedObject.accountID];
    model.timeStamp = [managedObject.timeStamp doubleValue];
    model.type = [managedObject.type integerValue];
    model.source = [managedObject.source integerValue];
    model.voice_time = [managedObject.voice_time intValue];
    model.isReviewd = [managedObject.isReviewd boolValue];
    model.isRecogized = [managedObject.isRecogized boolValue];
    model.isSendSuccess = [managedObject.isSendSuccess boolValue];
    
    return;
}

- (void)updateManagedObject:(Chat *)managedObject byModel:(ChatModel *)model
{
    managedObject.message = model.message;
    managedObject.fileName  = model.fileName;
    managedObject.accountID = model.accountID;
    managedObject.personId = model.person.personId;
    managedObject.groupId = model.group.groupId;
    managedObject.timeStamp = [NSNumber numberWithDouble:model.timeStamp];
    managedObject.type = [NSNumber numberWithInteger:model.type];
    managedObject.voice_time = [NSNumber numberWithInt:model.voice_time];
    managedObject.isReviewd = [NSNumber numberWithBool:model.isReviewd];
    managedObject.isRecogized = [NSNumber numberWithBool:model.isRecogized];
    managedObject.isSendSuccess = [NSNumber numberWithBool:model.isSendSuccess];
    managedObject.source = [NSNumber numberWithInteger:model.source];
    return;
}

- (NSMutableArray *)queryByGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    NSString *format1 = [NSString stringWithFormat:@"accountID = %@ AND ",accountID];
    NSString *format2 = [format1 stringByAppendingString:@"groupId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:groupId];
    return ar;
}

- (NSMutableArray *)queryByGroupIdSortForTimeStamp:(NSString *)groupId accountID:(NSString *)accountID limit:(NSInteger)limit offset:(NSInteger)offset
{
    NSString *format1 = [NSString stringWithFormat:@"accountID = %@ AND ",accountID];
    NSString *format2 = [format1 stringByAppendingString:@"groupId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:groupId sortKey:@"timeStamp" asc:NO limit:limit offset:offset];
    
    return ar;
}

- (ChatModel *)queryByGroupIdLastMessage:(NSString *)groupId accountID:(NSString *)accountID
{
    NSMutableArray *ar = [self queryByGroupIdSortForTimeStamp:groupId accountID:accountID limit:1 offset:0];
    return ar.firstObject;
}

- (NSMutableArray *)queryChatFilesByGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    NSString *format1 = [NSString stringWithFormat:@"(type = %@ OR type = %@) AND accountID = %@ AND ", [NSString stringWithFormat:@"%ld",(long)ChatVideo],[NSString stringWithFormat:@"%ld",(long)ChatImage],accountID];
    NSString *format2 = [format1 stringByAppendingString:@"groupId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:groupId];
    return ar;
}

- (NSMutableArray *)queryChatFilesByGroupIdSortForTimeStamp:(NSString *)groupId accountID:(NSString *)accountID limit:(NSInteger)limit offset:(NSInteger)offset
{
    NSString *format1 = [NSString stringWithFormat:@"(type = %@ OR type = %@) AND accountID = %@ AND ", [NSString stringWithFormat:@"%ld",(long)ChatVideo],[NSString stringWithFormat:@"%ld",(long)ChatImage],accountID];
    
    NSString *format2 = [format1 stringByAppendingString:@"groupId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:groupId sortKey:@"timeStamp" asc:NO limit:limit offset:offset];
    
    return ar;
}

- (BOOL)removeAllRecordGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    NSMutableArray *models = [self queryByGroupId:groupId accountID:accountID];
    for (ChatModel *model in models)
    {
        if(![self removeManagedObject:model.managedObjectID])
        {
            return NO;
        }
    }
    ChatModel *model = models.firstObject;
    if(model.group)
    {
         [[NSFileManager defaultManager] removeItemAtPath:model.group.groupFolderPath error:nil];
    }
    return YES;
}

+ (BOOL)removeAllRecordGroupId:(NSString *)groupId accountID:(NSString *)accountID
{
    ChatModelManager *modelManager = [ChatModelManager manager];
    return [modelManager removeAllRecordGroupId:groupId accountID:accountID];
}

@end

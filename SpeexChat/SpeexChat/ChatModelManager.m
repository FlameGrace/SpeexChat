//
//  ChatManager.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatModelManager.h"

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
    if(!managedObject || !model)return;
    model.message = managedObject.message;
    model.filePath = managedObject.filePath;
    model.personId = managedObject.personId;
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
    if(!managedObject || !model)return;
    managedObject.message = model.message;
    managedObject.filePath  = model.filePath;
    managedObject.personId = model.personId;
    managedObject.timeStamp = [NSNumber numberWithDouble:model.timeStamp];
    managedObject.type = [NSNumber numberWithInteger:model.type];
    managedObject.voice_time = [NSNumber numberWithInt:model.voice_time];
    managedObject.isReviewd = [NSNumber numberWithBool:model.isReviewd];
    managedObject.isRecogized = [NSNumber numberWithBool:model.isRecogized];
    managedObject.isSendSuccess = [NSNumber numberWithBool:model.isSendSuccess];
    managedObject.source = [NSNumber numberWithInteger:model.source];
    return;
}

- (NSMutableArray *)queryByPersonId:(NSString *)personId
{
    return  [self queryWithPredicateFormat:@"personId = %@" value:personId];
}

- (NSMutableArray *)queryByPersonIdSortForTimeStamp:(NSString *)personId limit:(NSInteger)limit offset:(NSInteger)offset
{
    NSString *format1 = @"personId = %@";
    NSMutableArray *ar = [self queryWithPredicateFormat:format1 value:personId sortKey:@"timeStamp" asc:NO limit:limit offset:offset];
    return ar;
}

- (NSMutableArray *)queryByPersonIdLastMessage:(NSString *)personId
{
    NSMutableArray *ar = [self queryByPersonIdSortForTimeStamp:personId limit:1 offset:0];;
    return ar.firstObject;
}

- (NSMutableArray *)queryChatFilesByPersonId:(NSString *)personId
{
    NSString *format1 = [NSString stringWithFormat:@"(type = %@ OR type = %@) AND ", [NSString stringWithFormat:@"%ld",(long)ChatVideo],[NSString stringWithFormat:@"%ld",(long)ChatImage]];
    NSString *format2 = [format1 stringByAppendingString:@"personId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:personId];
    return ar;
}

- (NSMutableArray *)queryChatFilesByPersonIdSortForTimeStamp:(NSString *)personId limit:(NSInteger)limit offset:(NSInteger)offset
{
    NSString *format1 = [NSString stringWithFormat:@"(type = %@ OR type = %@) AND ", [NSString stringWithFormat:@"%ld",(long)ChatVideo],[NSString stringWithFormat:@"%ld",(long)ChatImage]];
    NSString *format2 = [format1 stringByAppendingString:@"personId = %@"];
    NSMutableArray *ar = [self queryWithPredicateFormat:format2 value:personId sortKey:@"timeStamp" asc:NO limit:limit offset:offset];
    return ar;
}

- (BOOL)removeAllRecordPersonId:(NSString *)personId
{
    NSMutableArray *models = [self queryByPersonId:personId];
    for (ChatModel *model in models)
    {
        if(![self removeManagedObject:model.managedObjectID])
        {
            return NO;
        }
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[NSFileManager documenFullPath:[NSFileManager chatRelativePath:nil]] error:nil];
    return YES;
}

+ (BOOL)removeAllRecordPersonId:(NSString *)personId
{
    ChatModelManager *modelManager = [ChatModelManager manager];
    return [modelManager removeAllRecordPersonId:personId];
}

@end

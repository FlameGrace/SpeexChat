//
//  ChatGroupModel.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatGroupModel.h"

@implementation ChatGroupModel

@synthesize managedObjectID = _managedObjectID;
@synthesize groupId = _groupId;
@synthesize groupName = _groupName;
@synthesize groupType = _groupType;
@synthesize groupImage = _groupImage;
@synthesize noReadNumber = _noReadNumber;
@synthesize updateTime = _updateTime;
@synthesize accountID = _accountID;
@synthesize groupFolderPath = _groupFolderPath;

- (NSString *)groupFolderPath
{
    if(!_groupFolderPath)
    {
        NSString *path = [NSString stringWithFormat:@"%@/Chat/Group",self.accountID];
        if(self.groupId)
        {
            path = [path stringByAppendingString:self.groupId];
        }
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [paths objectAtIndex:0];
        NSString *fullPath = [documentPath stringByAppendingPathComponent:path];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        BOOL isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
        if(!isExist || !isDir)
        {
            NSError *error = nil;
            [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&error];
            if(error)
            { 
            }
        }
        _groupFolderPath = fullPath;
    }
    return _groupFolderPath;
}

- (NSString *)removeAllChatGroupMessagesNotificationName
{
    if(!_groupId)
    {
        return @"removeAllChatGroupMessagesNotificationName_NULL";
    }
    return [NSString stringWithFormat:@"removeAllChatGroupMessagesNotificationName_%@",_groupId];
}

- (NSString *)recieveAnNewChatGroupMessageNotificationName
{
    if(!_groupId)
    {
        return @"removeAllChatGroupMessagesNotificationName_NULL";
    }
    return [NSString stringWithFormat:@"recieveAnNewChatGroupMessageNotificationName_%@",_groupId];
}

@end

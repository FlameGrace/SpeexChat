//
//  ChatGroupMember.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ChatGroupMember : NSManagedObject

@property (nullable, nonatomic, retain) NSString *groupId;
@property (nullable, nonatomic, retain) NSString *personId;
@property (nullable, nonatomic, retain) NSString *accountID;

@end

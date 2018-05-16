//
//  ChatGroupMember.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ChatGroupMember : NSManagedObject

@property (nullable, nonatomic, retain) NSString *groupId;
@property (nullable, nonatomic, retain) NSString *personId;
@property (nullable, nonatomic, retain) NSString *accountID;

@end

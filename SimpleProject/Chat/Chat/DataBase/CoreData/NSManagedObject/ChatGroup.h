//
//  ChatGroup.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ChatGroup : NSManagedObject

@property (nullable, nonatomic, retain) NSString *groupId;
@property (nullable, nonatomic, retain) NSString *groupImage;
@property (nullable, nonatomic, retain) NSString *groupName;
@property (nullable, nonatomic, retain) NSNumber *noReadNumber;
@property (nullable, nonatomic, retain) NSNumber *groupType;
@property (nullable, nonatomic, retain) NSDate *updateTime;
@property (nullable, nonatomic, retain) NSString *accountID;

@end

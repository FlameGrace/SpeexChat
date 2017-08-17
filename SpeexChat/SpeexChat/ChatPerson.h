//
//  ChatPerson.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface ChatPerson : NSManagedObject

@property (nullable, nonatomic, retain) NSString *personId;
@property (nullable, nonatomic, retain) NSString *avatarImage;
@property (nullable, nonatomic, retain) NSString *nickName;
@property (nullable, nonatomic, retain) NSNumber *noReadNumber;

@end

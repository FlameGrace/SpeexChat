//
//  ChatPerson.h
//  SpeexChat
//
//  Created by lijj on 2017/7/25.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface ChatPerson : NSManagedObject

@property (nullable, nonatomic, retain) NSString *personId;
@property (nullable, nonatomic, retain) NSString *avatarImage;
@property (nullable, nonatomic, retain) NSString *nickName;
@property (nullable, nonatomic, retain) NSString *accountID;

@end

//
//  CarAppChatMessage.h
//  leapmotor
//
//  Created by lijj on 16/12/17.
//  Copyright © 2016年 leapmotor. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Chat : NSManagedObject

@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *fileName;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSString *groupId;
@property (nullable, nonatomic, retain) NSString *personId;
@property (nullable, nonatomic, retain) NSString *accountID;
@property (nullable, nonatomic, retain) NSNumber *timeStamp;
@property (nullable, nonatomic, retain) NSNumber *source;
@property (nullable, nonatomic, retain) NSNumber *voice_time;
@property (nullable, nonatomic, retain) NSNumber *isReviewd;
@property (nullable, nonatomic, retain) NSNumber *isRecogized;
@property (nullable, nonatomic, retain) NSNumber *isSendSuccess;

@end

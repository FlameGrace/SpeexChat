//
//  CarAppChatMessage.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Chat : NSManagedObject

@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *filePath;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSString *personId;
@property (nullable, nonatomic, retain) NSNumber *timeStamp;
@property (nullable, nonatomic, retain) NSNumber *source;
@property (nullable, nonatomic, retain) NSNumber *voice_time;
@property (nullable, nonatomic, retain) NSNumber *isReviewd;
@property (nullable, nonatomic, retain) NSNumber *isRecogized;
@property (nullable, nonatomic, retain) NSNumber *isSendSuccess;

@end

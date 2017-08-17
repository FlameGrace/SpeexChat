//
//  ChatPersonModelManager.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "CoreDataModelManager.h"
#import "ChatPerson.h"
#import "ChatPersonModel.h"

@interface ChatPersonModelManager : CoreDataModelManager

+ (NSMutableArray *)queryAll;

+ (ChatPersonModel *)queryByPersonId:(NSString *)personId;

+ (BOOL)removeRecordByPersonId:(NSString *)personId;

@end

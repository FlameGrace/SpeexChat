//
//  ChatPersonModelManager.h
//  SpeexChat
//
//  Created by lijj on 2017/7/25.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "CoreDataModelManager.h"
#import "ChatPerson.h"
#import "ChatPersonModel.h"

@interface ChatPersonModelManager : CoreDataModelManager

- (ChatPersonModel *)queryByPersonId:(NSString *)personId accountID:(NSString *)accountID;

- (BOOL)removeRecordByPersonId:(NSString *)personId accountID:(NSString *)accountID;

+ (ChatPersonModel *)queryByPersonId:(NSString *)personId accountID:(NSString *)accountID;

+ (BOOL)removeRecordByPersonId:(NSString *)personId accountID:(NSString *)accountID;

@end

//
//  ChatGroupMemberModel.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataModelProtocol.h"
#import "ChatGroupMemberProtocol.h"
#import "ChatGroupModel.h"
#import "ChatPersonModel.h"

@interface ChatGroupMemberModel : NSObject <ChatGroupMemberProtocol,CoreDataModelProtocol>

@property (strong, nonatomic) ChatGroupModel *group;
@property (strong, nonatomic) ChatPersonModel *person;

@end

//
//  ChatGroupModel.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataModelProtocol.h"
#import "ChatGroupModelProtocol.h"
#import "ChatPersonModel.h"

@interface ChatGroupModel : NSObject <ChatGroupModelProtocol,CoreDataModelProtocol>

@end

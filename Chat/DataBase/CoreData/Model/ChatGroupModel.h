//
//  ChatGroupModel.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataModelProtocol.h"
#import "ChatGroupModelProtocol.h"
#import "ChatPersonModel.h"

@interface ChatGroupModel : NSObject <ChatGroupModelProtocol,CoreDataModelProtocol>

@end

//
//  ChatModel.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//  聊天模块基础模型类，可被车机聊天，车友互动等情况复用

#import <UIKit/UIKit.h>
#import "ChatModelProtocol.h"
#import "CoreDataModelProtocol.h"


@interface ChatModel : NSObject <ChatModelProtocol,CoreDataModelProtocol>


- (void)copyChatValueForModel:(id<ChatModelProtocol>)model;


@end

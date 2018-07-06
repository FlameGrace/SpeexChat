//
//  ChatModel.h
//  Flame Grace
//
//  Created by lijj on 2017/3/24.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//  聊天模块基础模型类，可被车机聊天，车友互动等情况复用

#import <UIKit/UIKit.h>
#import "ChatModelProtocol.h"
#import "CoreDataModelProtocol.h"
#import "ChatPersonModel.h"
#import "ChatGroupModel.h"



@interface ChatModel : NSObject <ChatModelProtocol,CoreDataModelProtocol>

@property (strong, nonatomic) ChatGroupModel *group;
@property (strong, nonatomic) ChatPersonModel *person;

- (void)copyChatValueForModel:(id<ChatModelProtocol>)model;
//时间线
- (NSString *)timeLineDescription;

- (NSString *)filePath;


@end

//
//  LMCarChatView.h
//  Flame Grace
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatView_NoReadNumber.h"
#import "ChatModelManager.h"
#import "ChatGroupModel.h"

@interface ChatRecordView : ChatView_NoReadNumber

@property (strong, nonatomic) ChatGroupModel *group;
@property (assign, nonatomic) NSInteger loadOffset;//标记当前加载的数据位置

- (void)insertNewModel:(ChatModel *)model;
//第一次加载数据
- (void)loadMessagesFirst;

@end

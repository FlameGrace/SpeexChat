//
//  LMCarChatView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatView_NoReadNumber.h"
#import "ChatView+Broswer.h"
#import "ChatView+SpeexVoiceProcess.h"
#import "ChatModelManager.h"
#import "ChatPersonModel.h"

@interface ChatRecordView : ChatView_NoReadNumber

@property (strong, nonatomic) ChatPersonModel *person;
@property (strong, nonatomic) ChatModelManager *modelManager;
@property (assign, nonatomic) NSInteger loadOffset;//标记当前加载的数据位置
//第一次加载数据
- (void)loadMessagesFirst;

@end

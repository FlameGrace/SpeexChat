//
//  ChatRecordViewController.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/27.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatViewBaseController.h"
#import "ChatRecordView.h"

@interface ChatRecordViewController : ChatViewBaseController

@property (strong, nonatomic) ChatRecordView *chatView;
@property (strong , nonatomic) NSLayoutConstraint *chatViewBottomCon;
@property (strong, nonatomic) ChatGroupModel *group;

@end

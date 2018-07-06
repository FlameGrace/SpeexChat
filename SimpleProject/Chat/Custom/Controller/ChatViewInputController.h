//
//  ChatViewController.h
//  Chat
//
//  Created by MAC on 2018/5/11.
//  Copyright © 2018年 Flame Grace. All rights reserved.
//

#import "ChatRecordViewController.h"
#import "ChatInputView.h"
#import <AVFoundation/AVFoundation.h>

@interface ChatViewInputController : ChatRecordViewController <ChatInputViewDelegate>

@property (strong, nonatomic) ChatInputView *inputView;
@property (strong, nonatomic) ChatViewConfig *inputConfig;

@end

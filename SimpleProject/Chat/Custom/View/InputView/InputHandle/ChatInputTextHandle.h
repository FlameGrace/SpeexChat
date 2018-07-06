//
//  ChatInputTextHandle.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatInputBaseHandle.h"

@interface ChatInputTextHandle : ChatInputBaseHandle

- (void)inputNewTextMessage:(NSString *)message;

@end

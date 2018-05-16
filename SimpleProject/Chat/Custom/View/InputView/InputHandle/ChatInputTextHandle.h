//
//  ChatInputTextHandle.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatInputBaseHandle.h"

@interface ChatInputTextHandle : ChatInputBaseHandle

- (void)inputNewTextMessage:(NSString *)message;

@end

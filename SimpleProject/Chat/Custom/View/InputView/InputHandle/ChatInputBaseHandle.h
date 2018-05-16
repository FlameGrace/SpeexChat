//
//  ChatInputViewModel.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatInputHandleProtocol.h"


@interface ChatInputBaseHandle : NSObject <ChatInputHandleProtocol,ChatInputHandleDelegate>

- (id<ChatModelProtocol>)creatAnNewChatModel;

- (ChatType)inputType;

@end

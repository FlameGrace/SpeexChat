//
//  ChatInputViewModel.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/23.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatInputHandleProtocol.h"


@interface ChatInputBaseHandle : NSObject <ChatInputHandleProtocol,ChatInputHandleDelegate>

- (id<ChatModelProtocol>)creatAnNewChatModel;

- (ChatType)inputType;

@end

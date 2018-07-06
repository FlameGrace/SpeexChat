//
//  TextChatTableViewCell.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "TextChatTableViewCell.h"

@implementation TextChatTableViewCell
@synthesize messageView = _messageView;

- (TextChatPartView *)messageView
{
    if(!_messageView)
    {
        _messageView = [[TextChatPartView alloc]initWithConfig:self.config];
        [self addSubview:_messageView];
    }
    return _messageView;
}

@end

//
//  TextChatTableViewCell.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
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

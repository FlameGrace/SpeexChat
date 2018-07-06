//
//  VideoChatTableViewCell.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "VideoChatTableViewCell.h"

@implementation VideoChatTableViewCell
@synthesize messageView = _messageView;

- (VideoChatPartView *)messageView
{
    if(!_messageView)
    {
        _messageView = [[VideoChatPartView alloc]initWithConfig:self.config];
        [self addSubview:_messageView];
    }
    return _messageView;
}

@end

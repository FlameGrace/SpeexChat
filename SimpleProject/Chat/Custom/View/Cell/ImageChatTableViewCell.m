//
//  ImageChatTableViewCell.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ImageChatTableViewCell.h"

@implementation ImageChatTableViewCell
@synthesize messageView = _messageView;

- (ImageChatPartView *)messageView
{
    if(!_messageView)
    {
        _messageView = [[ImageChatPartView alloc]initWithConfig:self.config];
        [self addSubview:_messageView];
    }
    return _messageView;
}

@end

//
//  CarChatTextView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/4.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatTextView.h"

@implementation ChatTextView


- (void)updateViewByModel:(ChatModel *)model
{
    [super updateViewByModel:model];
    self.messageLabel.text = model.message;
    CGSize size = [self.messageLabel.text sizeWithFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(MainScreenWidth - 60 - 17 -17 , MAXFLOAT)];
    self.messageLabel.frame = CGRectMake(8.5, 12, size.width, size.height);
    
    CGRect frame = self.frame;
    frame.size.width = size.width + 17;
    frame.size.height = size.height + 24;
    self.frame = frame;
    [self updateViewForSource];
    
}

- (void)sourceOtherView
{
    [super sourceOtherView];
    self.messageLabel.textColor = [UIColor grayColor];
}

- (void)sourceMeView
{
    [super sourceMeView];
    self.messageLabel.textColor = [UIColor whiteColor];
}


- (UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

@end

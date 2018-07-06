//
//  VoiceChatTableViewCell.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "VoiceChatTableViewCell.h"

@implementation VoiceChatTableViewCell
@synthesize messageView = _messageView;


- (void)chatView:(UIView *)view clickedModel:(id<ChatModelProtocol>)model
{
    if(self.model.type == ChatVoice && self.model.source == ChatSourceOther)
    {
        if(!self.model.isReviewd)
        {
            self.model.isReviewd = YES;
            [self.messageView updateIsReviewed];
            [self chatView:view needSaveModel:model];
        }
    }
    [super chatView:view clickedModel:model];
}

- (VoiceChatPartView *)messageView
{
    if(!_messageView)
    {
        _messageView = [[VoiceChatPartView alloc]initWithConfig:self.config];
        [self addSubview:_messageView];
    }
    return _messageView;
}

@end

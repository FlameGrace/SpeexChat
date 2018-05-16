//
//  ChatPersonTableViewCell.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatGroupTableViewCell.h"

@implementation ChatGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.noReadNumber.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateByGroup:(ChatGroupModel *)group
{
    if(group.groupImage)
    {
        self.avatar.image = [UIImage imageNamed:group.groupImage];
    }
    self.message.text = @"";
    if(group.groupId)
    {
        ChatModelManager *modelManager = [ChatModelManager manager];
        ChatModel *lastMessage = [modelManager queryByGroupIdLastMessage:group.groupId accountID:AccountID];
        if(lastMessage&&lastMessage.message&&lastMessage.message.length>0)
        {
            self.message.text = lastMessage.message;
        }
    }
    self.nick.text = group.groupName;
    if(group.noReadNumber < 1)
    {
        self.noReadNumber.hidden = YES;
    }
    else
    {
        self.noReadNumber.hidden = NO;
        self.noReadNumber.text = [NSString stringWithFormat:@"%ld",group.noReadNumber];
    }
}

@end

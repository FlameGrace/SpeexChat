//
//  ChatPersonTableViewCell.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatPersonTableViewCell.h"

@implementation ChatPersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.noReadNumber.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateByPerson:(ChatPersonModel *)person
{
    if(person.avatarImage)
    {
        self.avatar.image = [UIImage imageNamed:person.avatarImage];
    }
    self.message.text = @"";
    if(person.personId)
    {
        ChatModelManager *modelManager = [ChatModelManager manager];
        ChatModel *lastMessage = [modelManager queryByPersonIdLastMessage:person.personId];
        if(lastMessage&&lastMessage.message&&lastMessage.message.length>0)
        {
            self.message.text = lastMessage.message;
        }
    }
    self.nick.text = person.nickName;
    if(person.noReadNumber < 1)
    {
        self.noReadNumber.hidden = YES;
    }
    else
    {
        self.noReadNumber.hidden = NO;
        self.noReadNumber.text = [NSString stringWithFormat:@"%ld",person.noReadNumber];
    }
}

@end

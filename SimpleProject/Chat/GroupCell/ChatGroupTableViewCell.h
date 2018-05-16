//
//  ChatPersonTableViewCell.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatGroupModel.h"
#import "ChatModelManager.h"

@interface ChatGroupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *noReadNumber;

- (void)updateByGroup:(ChatGroupModel *)group;

@end

//
//  VideoChatTableViewCell.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatBaseTableViewCell.h"
#import "VideoChatPartView.h"

@interface VideoChatTableViewCell : ChatBaseTableViewCell

@property (strong, nonatomic) VideoChatPartView *messageView;

@end

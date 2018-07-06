//
//  VideoChatTableViewCell.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatBaseTableViewCell.h"
#import "VideoChatPartView.h"

@interface VideoChatTableViewCell : ChatBaseTableViewCell

@property (strong, nonatomic) VideoChatPartView *messageView;

@end

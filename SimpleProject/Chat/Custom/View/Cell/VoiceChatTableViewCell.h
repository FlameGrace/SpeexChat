//
//  VoiceChatTableViewCell.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatBaseTableViewCell.h"
#import "VoiceChatPartView.h"

@interface VoiceChatTableViewCell : ChatBaseTableViewCell

@property (strong, nonatomic) VoiceChatPartView *messageView;

@end

//
//  TextChatTableViewCell.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatBaseTableViewCell.h"
#import "TextChatPartView.h"

@interface TextChatTableViewCell : ChatBaseTableViewCell

@property (strong, nonatomic) TextChatPartView *messageView;

@end

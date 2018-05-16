//
//  ImageChatTableViewCell.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatBaseTableViewCell.h"
#import "ImageChatPartView.h"

@interface ImageChatTableViewCell : ChatBaseTableViewCell

@property (strong, nonatomic) ImageChatPartView *messageView;

@end

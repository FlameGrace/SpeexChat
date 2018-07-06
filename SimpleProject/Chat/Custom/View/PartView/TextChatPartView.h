//
//  ChatTextPartView.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatPartView.h"

@interface TextChatPartView : ChatPartView

@property (assign, nonatomic) UIEdgeInsets edgeInset;
@property (assign, nonatomic) CGFloat textLabelMaxWidth;
@property (strong, nonatomic) UILabel *textLabel;

@end

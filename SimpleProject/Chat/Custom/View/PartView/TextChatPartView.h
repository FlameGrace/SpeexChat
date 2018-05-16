//
//  ChatTextPartView.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatPartView.h"

@interface TextChatPartView : ChatPartView

@property (assign, nonatomic) UIEdgeInsets edgeInset;
@property (assign, nonatomic) CGFloat textLabelMaxWidth;
@property (strong, nonatomic) UILabel *textLabel;

@end

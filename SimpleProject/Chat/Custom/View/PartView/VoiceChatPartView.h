//
//  ChatVoicePartView.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatPartView.h"

@interface VoiceChatPartView : ChatPartView

@property (assign, nonatomic) CGFloat maxWidth;
//语音图片
@property (strong, nonatomic) UIImageView *imageView;
//语音时间标签
@property (strong, nonatomic) UILabel *timeLabel;


- (void)updateVoicePlayUI;

- (void)updateIsReviewed;

@end

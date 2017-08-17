//
//  CarVoiceMessageView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatPartView.h"

//语音视图
@interface ChatVoiceView : ChatPartView

//语音图片
@property (strong, nonatomic) UIImageView *imageView;
//语音时间标签
@property (strong, nonatomic) UILabel *timeLabel;


- (void)updateViewByModel:(ChatModel *)model;
- (void)updateVoicePlayUI;
- (void)updateIsReviewed;


@end

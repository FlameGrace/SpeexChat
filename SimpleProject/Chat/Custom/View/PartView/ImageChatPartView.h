//
//  ChatImagePartView.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatPartView.h"

@interface ImageChatPartView : ChatPartView

@property (assign, nonatomic) CGSize imageSize;
@property (strong, nonatomic) UIImageView *prevImageView;

- (void)setPrevImage:(UIImage *)image;

@end

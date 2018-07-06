//
//  ChatPartView.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewConfig.h"
#import "ChatPartViewProtocol.h"

@interface ChatPartView : UIView <ChatPartViewProtocol>

@property (readonly,strong,nonatomic) ChatViewConfig *config;

- (instancetype)initWithConfig:(ChatViewConfig *)config;

@end

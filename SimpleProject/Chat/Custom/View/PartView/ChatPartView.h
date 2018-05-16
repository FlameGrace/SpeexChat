//
//  ChatPartView.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewConfig.h"
#import "ChatPartViewProtocol.h"

@interface ChatPartView : UIView <ChatPartViewProtocol>

@property (readonly,strong,nonatomic) ChatViewConfig *config;

- (instancetype)initWithConfig:(ChatViewConfig *)config;

@end

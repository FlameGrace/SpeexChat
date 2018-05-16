//
//  ChatPartViewConfig.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/27.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ChatViewConfig : NSObject

@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat textFontSize;
@property (assign, nonatomic) CGFloat nickTextFontSize;
@property (strong, nonatomic) UIColor *nickTextColor;
@property (assign, nonatomic) CGFloat timeLineTextFontSize;
@property (strong, nonatomic) UIColor *timeLineTextColor;
@property (strong, nonatomic) UIColor *otherTextColor;
@property (strong, nonatomic) UIColor *meTextColor;
@property (strong, nonatomic) UIColor *otherBackGroundColor;
@property (strong, nonatomic) UIColor *meBackGroundColor;

@property (strong, nonatomic) UIColor *inputVoiceButtonBackGroudColor;
@property (strong, nonatomic) UIColor *inputVoiceButtonTextColor;
@property (strong, nonatomic) UIColor *inputVoiceButtonBorderColor;
@property (strong, nonatomic) UIColor *inputSendButtonTextColor;
@property (strong, nonatomic) UIColor *inputSendButtonBackGroudColor;
@property (strong, nonatomic) UIColor *inputSendButtonDisabledBackGroudColor;

@end

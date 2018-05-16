//
//  ChatPartViewConfig.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/27.
//  Copyright © 2017年 leapmotor. All rights reserved.
//


#import "ChatViewConfig.h"

@implementation ChatViewConfig

- (instancetype)init
{
    if(self = [super init])
    {
        self.leftMargin = 8.0;
        self.cornerRadius = 8.0;
        self.textFontSize = 16.0;
        self.nickTextFontSize = 12.0;
        self.nickTextColor = [UIColor redColor];
        self.otherTextColor = [UIColor blueColor];
        self.meTextColor = [UIColor whiteColor];
        self.otherBackGroundColor = [UIColor whiteColor];
        self.meBackGroundColor = [UIColor blueColor];
        self.timeLineTextColor = [UIColor redColor];
        self.timeLineTextFontSize = 12.0;
        
        self.inputSendButtonTextColor = [UIColor whiteColor];
        self.inputSendButtonBackGroudColor = [UIColor blueColor];
        self.inputSendButtonDisabledBackGroudColor = [UIColor grayColor];
        self.inputVoiceButtonBorderColor = [UIColor grayColor];
        self.inputVoiceButtonTextColor = [UIColor grayColor];
        self.inputVoiceButtonBackGroudColor = [UIColor whiteColor];
    }
    return self;
}


@end

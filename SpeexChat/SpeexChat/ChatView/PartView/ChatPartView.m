//
//  CarChatView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/4.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatPartView.h"

@implementation ChatPartView
@synthesize model = _model;

//根据消息更新视图
- (void)updateViewByModel:(ChatModel *)model
{
    self.model = model;
}

//根据source更新视图
- (void)updateViewForSource
{
    if(self.model.source == ChatSourceMe)
    {
        [self sourceMeView];
    }
    if(self.model.source == ChatSourceOther)
    {
        [self sourceOtherView];
    }
}
//设置来源为自己时的视图
- (void)sourceMeView
{
    
}
//设置来源为其他人时的视图
- (void)sourceOtherView
{
    
}

@end

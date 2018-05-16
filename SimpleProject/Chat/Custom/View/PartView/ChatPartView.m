//
//  ChatPartView.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatPartView.h"

@interface ChatPartView()

@property (readwrite,strong,nonatomic) ChatViewConfig *config;

@end

@implementation ChatPartView

@synthesize model = _model;
@synthesize config = _config;

- (instancetype)initWithConfig:(ChatViewConfig *)config
{
    if(self = [self init])
    {
        self.config = config;
    }
    return self;
}

//根据消息更新视图
- (void)updateViewByModel:(id<ChatModelProtocol>)model
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


- (ChatViewConfig *)config
{
    if(!_config)
    {
        _config = [[ChatViewConfig alloc]init];
    }
    return _config;
}

@end

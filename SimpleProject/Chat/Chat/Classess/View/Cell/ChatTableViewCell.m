//
//  NewchatView.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatTableViewCell.h"

@interface ChatTableViewCell()

@end

@implementation ChatTableViewCell
@synthesize model = _model;
@synthesize delegate = _delegate;

+ (instancetype)cell
{
    return [[self alloc]init];
}

+ (CGRect)boundsForModel:(id<ChatModelProtocol>)model
{
    ChatTableViewCell *cell = [self cell];
    CGRect bounds = [UIScreen mainScreen].bounds;
    cell.width = bounds.size.width;
    [cell updateViewByModel:model];
    return cell.frame;
}

- (instancetype)init
{
    if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])])
    {
        
    }
    return self;
}

//点击事件
- (void)chatView:(UIView *)view  clickedModel:(id<ChatModelProtocol>)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:clickedModel:)])
    {
        [self.delegate chatView:view clickedModel:model];
    }
}
//需要重新发送该消息
- (void)chatView:(UIView *)view  needResendModel:(id<ChatModelProtocol>)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:needResendModel:)])
    {
        [self.delegate chatView:view needResendModel:model];
    }
}
//需要保存此消息的更新
- (void)chatView:(UIView *)view  needSaveModel:(id<ChatModelProtocol>)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:needSaveModel:)])
    {
        [self.delegate chatView:view needSaveModel:model];
    }
}


- (void)updateViewByModel:(id<ChatModelProtocol>)model
{
    self.model = model;
}

- (void)sourceMeView
{
    
}


- (void)sourceOtherView
{
    
}


- (void)updateViewForSource
{
    
}






@end

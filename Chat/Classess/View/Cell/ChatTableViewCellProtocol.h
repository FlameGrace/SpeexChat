//
//  chatViewProtocol.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/22.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatPartViewProtocol.h"

@protocol ChatTableViewCellDelegate;

@protocol ChatTableViewCellProtocol <ChatPartViewProtocol>

@property (weak, nonatomic) id <ChatTableViewCellDelegate> delegate;
//根据消息获取对应视图大小
+ (CGRect)boundsForModel:(id<ChatModelProtocol>)model;

@end


@protocol ChatTableViewCellDelegate <NSObject>

@optional
//点击事件
- (void)chatView:(UIView *)view  clickedModel:(id<ChatModelProtocol>)model;
//需要重新发送该消息
- (void)chatView:(UIView *)view  needResendModel:(id<ChatModelProtocol>)model;
//需要保存此消息的更新
- (void)chatView:(UIView *)view  needSaveModel:(id<ChatModelProtocol>)model;


@end

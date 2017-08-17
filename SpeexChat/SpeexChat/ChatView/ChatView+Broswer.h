//
//  ChatView+Broswer.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// // 聊天页面扩展，实现浏览图片和视频的方法

#import "ChatView.h"
#import "ChatModel.h"

@interface ChatView (Broswer)

//浏览图片
- (void)broswerImage:(ChatModel *)model;

//浏览视频
- (void)broswerVideo:(ChatModel *)model isSupportOrientation:(BOOL *)isSupportOrientation;


@end

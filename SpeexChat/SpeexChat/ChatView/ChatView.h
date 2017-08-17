//
//  ChatView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//  一个普通聊天视图,不包含语音播放，识别等处理

#import <UIKit/UIKit.h>
#import "ChatTableViewCell.h"
#import "ChatModel.h"


@interface ChatView : UIView <UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,ChatViewDelegate>

@property (weak, nonatomic) id<ChatViewDelegate>delegate;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isScrollToBottom;
//控制是否显示语音识别成文字
@property (assign, nonatomic) BOOL showRecognizeView;

- (void)insertNewModel:(ChatModel *)model;

- (void)scrollToBottomAnimation:(BOOL)animated;

- (ChatTableViewCell *)cellForModel:(ChatModel *)model;

- (void)reloadCellForModel:(ChatModel *)model;


@end

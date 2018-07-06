//
//  ChatView.h
//  Flame Grace
//
//  Created by lijj on 2017/3/24.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//  一个普通聊天视图,不包含语音播放，识别等处理

#import <UIKit/UIKit.h>
#import "ChatViewProtocol.h"
#import "ChatTableViewCell.h"

@interface ChatView : UIView <UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,ChatViewProtocol,ChatViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isScrollToBottom;

- (void)insertNewModel:(id<ChatModelProtocol>)model;

- (void)scrollToBottomAnimation:(BOOL)animated;

- (UITableViewCell <ChatTableViewCellProtocol> *)cellForModel:(id<ChatModelProtocol>)model;

- (void)reloadCellForModel:(id<ChatModelProtocol>)model;


@end

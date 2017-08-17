//
//  LMCarChatView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatRecordView.h"
#import "MJRefreshSimpleHeader.h"

@interface ChatRecordView()


@end

@implementation ChatRecordView

- (void)chatView:(ChatView *)chatView  clickedModel:(ChatModel *)model
{
    if(model.type == ChatVoice)
    {
        [self startPlayVoice:model];
    }
    if(model.type == ChatImage)
    {
        [self broswerImage:model];
    }
    if(model.type == ChatVideo)
    {
//        [self broswerVideo:model];
    }
    [super chatView:self clickedModel:model];
}

- (void)chatView:(ChatView *)chatView  needReVoiceRecognizeModel:(ChatModel *)model
{
    [self recognizeVoice:model];
    [super chatView:self needReVoiceRecognizeModel:model];
}

- (void)chatView:(ChatView *)chatView  needResendModel:(ChatModel *)model
{
    [super chatView:self needResendModel:model];
}

- (void)chatView:(ChatView *)chatView  needSaveModel:(ChatModel *)model
{
    [self.modelManager update:model];
    [super chatView:self needSaveModel:model];
}


/**
 重新加载数据源，重载UITableView
 */
- (void)loadMessagesFirst
{
    self.dataSource = nil;
    self.loadOffset = 0;
    NSMutableArray *ar = [self.modelManager queryByPersonIdSortForTimeStamp:self.person.nickName limit:10 offset:self.loadOffset];
    
    self.dataSource = (NSMutableArray *)[[ar reverseObjectEnumerator] allObjects];
    self.loadOffset = self.dataSource.count;
    if([self.modelManager queryByPersonId:self.person.nickName].count > 10)
    {
        MJRefreshSimpleHeader *header = [MJRefreshSimpleHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMoreData)];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        header.stateLabel.hidden = YES;
        // 设置header
        self.tableView.mj_header = header;
        
    }
    else
    {
        [self.tableView.mj_header removeFromSuperview];
        self.tableView.mj_header = nil;
    }
    [self.tableView reloadData];
}

/**
 上拉加载更多数据
 */
- (void)refreshLoadMoreData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableArray *ar = [self.modelManager queryByPersonIdSortForTimeStamp:self.person.nickName limit:10 offset:self.loadOffset];
        
        self.loadOffset += ar.count;
        for (ChatModel *model in ar) {
            [self.dataSource insertObject:model atIndex:0];
        }
        
        [self.tableView reloadData];
        //表格应滚动到原位置
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:ar.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self.tableView.mj_header endRefreshing];
        //如果全部加载完毕，应移除refreshControl
        if(ar.count < 10)
        {
            [self.tableView.mj_header removeFromSuperview];
            self.tableView.mj_header = nil;
            return ;
        }
    });
}


- (ChatModelManager *)modelManager
{
    if(!_modelManager)
    {
        _modelManager = [ChatModelManager manager];
    }
    return _modelManager;
}

@end

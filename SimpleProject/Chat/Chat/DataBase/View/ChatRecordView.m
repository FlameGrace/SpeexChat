//
//  LMCarChatView.m
//  leapmotor
//
//  Created by lijj on 2017/3/27.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatRecordView.h"
#import "MJRefreshSimpleHeader.h"

@interface ChatRecordView()


@end

@implementation ChatRecordView

- (void)chatView:(UIView *)view needSaveModel:(ChatModel*)model
{
    ChatModelManager *modelManager = [ChatModelManager manager];
    [modelManager update:model];
    [super chatView:view needSaveModel:model];
}

- (void)insertNewModel:(ChatModel *)model
{
    if(!model.managedObjectID)
    {
        ChatModelManager *modelManager = [ChatModelManager manager];
        [modelManager createNewManagedObjectByModel:model];
        ChatGroupModelManager *manager = [ChatGroupModelManager manager];
        [manager updateTime:[NSDate dateWithTimeIntervalSince1970:model.timeStamp] toGroup:model.group];
    }
    if(model.managedObjectID)
    {
        self.loadOffset += 1;
    }
    [super insertNewModel:model];
}

/**
 重新加载数据源，重载UITableView
 */
- (void)loadMessagesFirst
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataSource = nil;
        self.loadOffset = 0;
        ChatModelManager *modelManager = [ChatModelManager manager];
        NSMutableArray *ar = [modelManager queryByGroupIdSortForTimeStamp:self.group.groupId accountID:self.group.accountID limit:10 offset:self.loadOffset];
        
        self.dataSource = (NSMutableArray *)[[ar reverseObjectEnumerator] allObjects];
        self.loadOffset = self.dataSource.count;
        if([modelManager queryByGroupId:self.group.groupId accountID:self.group.accountID].count > 10)
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
    });
}

/**
 上拉加载更多数据
 */
- (void)refreshLoadMoreData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ChatModelManager *modelManager = [ChatModelManager manager];
        NSMutableArray *ar = [modelManager queryByGroupIdSortForTimeStamp:self.group.groupId accountID:self.group.accountID limit:10 offset:self.loadOffset];
        
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

@end

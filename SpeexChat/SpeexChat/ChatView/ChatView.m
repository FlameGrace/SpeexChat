//
//  ChatView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatView.h"

@interface ChatView()


@end


@implementation ChatView

static NSString *ChatTableViewCellIdentifier = @"ChatTableViewCellIdentifier";

- (void)insertNewModel:(ChatModel *)model
{
    [self.dataSource addObject:model];
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        //必须刷新空白section，不然会出现插入动画
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [self.tableView reloadData];
        
        if(self.isScrollToBottom)
        {
            [self scrollToBottomAnimation:NO];
        }
    });

    
}


#pragma ChatViewDelegate

- (void)chatView:(ChatView *)chatView  clickedModel:(ChatModel *)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:clickedModel:)])
    {
        [self.delegate chatView:self clickedModel:model];
    }
}

- (void)chatView:(ChatView *)chatView  needResendModel:(ChatModel *)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:needResendModel:)])
    {
        [self.delegate chatView:self needResendModel:model];
    }
}

- (void)chatView:(ChatView *)chatView  needSaveModel:(ChatModel *)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:needSaveModel:)])
    {
        [self.delegate chatView:self needSaveModel:model];
    }
}

- (void)chatView:(ChatView *)chatView  needReVoiceRecognizeModel:(ChatModel *)model
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(chatView:needReVoiceRecognizeModel:)])
    {
        [self.delegate chatView:self needReVoiceRecognizeModel:model];
    }
}

- (ChatTableViewCell *)cellForModel:(ChatModel *)model
{
    NSInteger row = [self.dataSource indexOfObject:model];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    ChatTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(cell && [cell isKindOfClass:[ChatTableViewCell class]])
    {
        return cell;
    }
    
    return nil;
}

- (void)reloadCellForModel:(ChatModel *)model
{
    NSInteger row = [self.dataSource indexOfObject:model];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    if(indexPath)
    {
        dispatch_async(dispatch_get_main_queue(),^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    }
}

- (void)scrollToBottomAnimation:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(),^{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        self.isScrollToBottom = YES;
    });
    
}

//此方法判断是否滚动到底部
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断是否滚动到底部
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSArray *array = [self.tableView visibleCells];
    if([array containsObject:cell])
    {
        self.isScrollToBottom = YES;
        return;
    }
    self.isScrollToBottom = NO;
    
}




/**
 使用两个section，一个存放消息，另一个只有一个空白cell
 这样做是因为此页面需要经常滚到到页面底部，但是普通的滚动到页面的方法不太奏效（与tableView.contenSize不能实时刷新有关），因此多添加了一个section
 每次滚动到底部直接滚动到这个空白cell就好了
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1)
    {
        return 1;
    }
    return [self.dataSource count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        return 44;
    }
    ChatModel *model = self.dataSource[indexPath.row];
    CGRect bounds = [ChatTableViewCell boundsForModel:model];
    return bounds.size.height;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        NSString *cellIdentifer = @"CarChatSpaceTableViewCell";
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    ChatModel *model = self.dataSource[indexPath.row];
    //添加时间线
    if(indexPath.row == 0)
    {
        model.isShowTimeLine = YES;
    }
    else
    {
        ChatModel *lastModel = self.dataSource[indexPath.row-1];
        //如果与上一条消息相差10分钟，则显示timeLine
        if(model.timeStamp - lastModel.timeStamp > 60*10)
        {
            model.isShowTimeLine = YES;
        }
    }
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChatTableViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    __weak typeof(self) weakSelf = self;
    cell.reloadBlock = ^(NSError *error)
    {
        __strong typeof(weakSelf) self = weakSelf;
        [self reloadCellForModel:model];
    };
    [cell updateViewByModel:model];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [_tableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:ChatTableViewCellIdentifier];
    }
    return _tableView;
}


- (NSMutableArray *)dataSource
{
    if(!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}




@end

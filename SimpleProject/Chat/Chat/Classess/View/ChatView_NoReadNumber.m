//
//  ChatView_NoReadNumber.m
//  Flame Grace
//
//  Created by lijj on 2017/3/27.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "ChatView_NoReadNumber.h"

@implementation ChatView_NoReadNumber

- (void)insertNewModel:(id<ChatModelProtocol>)model
{
    [super insertNewModel:model];
    if(!self.isScrollToBottom)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.dataSource indexOfObject:model] inSection:0];
        [self.noReadIndexPaths addObject:indexPath];
        [self updateNoReadNumberButton];
    }
}


- (void)scrollToBottomAnimation:(BOOL)animated
{
    [super scrollToBottomAnimation:animated];
    self.noReadIndexPaths = nil;
    [self updateNoReadNumberButton];
    
}

//此方法主要为了改变self.noReadNumber和self.noReadNumberButton
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    if(self.isScrollToBottom)
    {
        self.noReadIndexPaths = nil;
        [self updateNoReadNumberButton];
        return;
    }
    
    //没有未读消息
    if(self.noReadIndexPaths.count<1)
    {
        return;
    }
    
    NSArray *array = [self.tableView visibleCells];
    for (UITableViewCell *cell in array)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        NSMutableArray *noReadIndexPaths = [[NSMutableArray alloc]initWithArray:self.noReadIndexPaths];
        [noReadIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.row == indexPath.row)
            {
                [self.noReadIndexPaths removeObject:obj];
                [self updateNoReadNumberButton];
            }
        }];
    }
}

- (void)setHiddenNoReadNumberButton:(BOOL)hiddenNoReadNumberButton
{
    _hiddenNoReadNumberButton = hiddenNoReadNumberButton;
    [self updateNoReadNumberButton];
}

- (void)updateNoReadNumberButton
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self update];
    });
}

- (void)update
{
    if(_hiddenNoReadNumberButton)
    {
        _noReadNumberButton.hidden = YES;
        return;
    }
    NSInteger noReadNumber = _noReadIndexPaths.count;
    
    if(!noReadNumber)
    {
        _noReadNumberButton.hidden = YES;
        return;
    }
    NSString *text = [NSString stringWithFormat:@"%ld",(long)noReadNumber];
    if(noReadNumber > 99)
    {
        text = @"99+";
    }
    [_noReadNumberButton setTitle:text forState:UIControlStateNormal];
    _noReadNumberButton.hidden = NO;
}


- (void)btnClickNoReadNumberButton
{
    [self scrollToBottomAnimation:NO];
}



- (UIButton *)noReadNumberButton
{
    if(!_noReadNumberButton)
    {
        _noReadNumberButton = [[UIButton alloc]init];
        _noReadNumberButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_noReadNumberButton];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_noReadNumberButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_noReadNumberButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_noReadNumberButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_noReadNumberButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
        
        [_noReadNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _noReadNumberButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_noReadNumberButton addTarget:self action:@selector(btnClickNoReadNumberButton) forControlEvents:UIControlEventTouchUpInside];
        [_noReadNumberButton setTitle:@"0" forState:UIControlStateNormal];
        _noReadNumberButton.backgroundColor = [UIColor blueColor];
        _noReadNumberButton.layer.cornerRadius = 15;
        _noReadNumberButton.hidden = YES;
    }
    return _noReadNumberButton;
}


- (NSMutableArray *)noReadIndexPaths
{
    
    if(!_noReadIndexPaths)
    {
        _noReadIndexPaths = [[NSMutableArray alloc]init];
    }
    return _noReadIndexPaths;
}



@end

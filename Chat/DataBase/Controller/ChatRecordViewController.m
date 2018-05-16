//
//  ChatRecordViewController.m
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/27.
//  Copyright © 2017年 leapmotor. All rights reserved.
//

#import "ChatRecordViewController.h"

@interface ChatRecordViewController ()

@property (strong, nonatomic) ChatRecordView *myChatView;


@end

@implementation ChatRecordViewController
@synthesize group = _group;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self myChatView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ChatGroupModelManager stopCountNoReadNumberForGroupId:self.group.groupId accountID:self.group.accountID];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [ChatGroupModelManager startCountNoReadNumberForGroupId:self.group.groupId accountID:self.group.accountID];
}


- (void)keyboardWillShow:(CGFloat)duration height:(CGFloat)height
{
    [UIView animateWithDuration:duration animations:^{
        self.chatViewBottomCon.constant = - height - 52;
    } completion:^(BOOL finished) {
        [self.chatView performSelector:@selector(scrollToBottomAnimation:) withObject:nil afterDelay:0];
    }];
}


- (void)keyboardWillHide:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.chatViewBottomCon.constant = -52;
    }];
}

- (void)reloadChatList
{
    [self.chatView loadMessagesFirst];
}

- (ChatRecordView *)chatView
{
    return self.myChatView;
}

- (ChatRecordView *)myChatView
{
    if(!_myChatView)
    {
        _myChatView = [[ChatRecordView alloc]init];
        _myChatView.group = self.group;
        _myChatView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_myChatView];
        _myChatView.delegate = self;
        _myChatView.backgroundColor = [UIColor lightGrayColor];
        self.chatViewBottomCon = [NSLayoutConstraint constraintWithItem:_myChatView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-52];
        [self.view addConstraint:self.chatViewBottomCon];
        [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:_myChatView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view  attribute:NSLayoutAttributeTop multiplier:1.0 constant:64]];
        [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:_myChatView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view  attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:_myChatView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
        [self reloadChatList];
    }
    return _myChatView;
}



@end

//
//  MessageViewController.m
//  leapmotor
//
//  Created by lijj on 2017/2/24.
//  Copyright © 2017年 leapmotor. All rights reserved.
//
#import "ChatViewBaseController.h"
#import <AVFoundation/AVFoundation.h>

@interface ChatViewBaseController ()

@end

@implementation ChatViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.group.groupName;
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestRecordPermission];
    [self observeNotifycations];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLayoutSubviews
{
    //确认是第一次加载时才滚动到底部
    if(!isViewLoaded)
    {
        [self.chatView scrollToBottomAnimation:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //在此再调用一次才能无瑕疵的滚动到底部
    if(!isViewLoaded)
    {
        [self.chatView scrollToBottomAnimation:NO];
        isViewLoaded = YES;
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)reloadChatList
{
    [_chatView.tableView reloadData];
}

#pragma 滑动隐藏键盘
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [self.view endEditing:YES];
    return NO;
}



#pragma 接收到一键分享的通知
- (void)recieveAnNewChatGroupMessageNotification:(NSNotification *)notification
{
    
    id<ChatModelProtocol> newMessage = notification.userInfo[RecieveAnNewChatGroupMessageNotificationMessageKey];
    if(newMessage&&[newMessage conformsToProtocol:NSProtocolFromString(@"ChatModelProtocol")]&&[newMessage.group.groupId isEqualToString:self.group.groupId])
    {
        [self.chatView insertNewModel:newMessage];
    }
}

//接收到清除消息记录的通知时
- (void)removeAllChatGroupMessagesNotification:(NSNotification *)notification
{
    [self reloadChatList];
}

//当键盘显示时调用
- (void)keyboardWillShowNotification:(NSNotification *)aNotification
{
    [self.chatView addGestureRecognizer:self.hideKeyboardGesture];
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *aDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardDuration = aDuration.floatValue;
    int height = keyboardRect.size.height;
    [self keyboardWillShow:keyboardDuration height:height];
}



//当键盘退出时调用
- (void)keyboardWillHideNotification:(NSNotification *)aNotification
{
    [self.chatView removeGestureRecognizer:self.hideKeyboardGesture];
    NSDictionary *userInfo = [aNotification userInfo];
    NSNumber *aDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGFloat keyboardDuration = aDuration.floatValue;
    [self keyboardWillHide:keyboardDuration];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    
}



- (void)popToPrevPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillHide:(CGFloat)duration
{
}

- (void)keyboardWillShow:(CGFloat)duration height:(CGFloat)height
{
    
}

- (void)observeNotifycations
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    if([self.group recieveAnNewChatGroupMessageNotificationName])
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveAnNewChatGroupMessageNotification:) name:[self.group recieveAnNewChatGroupMessageNotificationName] object:nil];
    }
    
    if([self.group removeAllChatGroupMessagesNotificationName])
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeAllChatGroupMessagesNotification:) name:[self.group removeAllChatGroupMessagesNotificationName] object:nil];
    }
}

/**
 请求录音权限
 */
- (void)requestRecordPermission
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if(authStatus != AVAuthorizationStatusAuthorized)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted)
                {
                    
                }
            }];
        }
    }
}


- (UIPanGestureRecognizer *)hideKeyboardGesture
{
    if(!_hideKeyboardGesture)
    {
        _hideKeyboardGesture = [[UIPanGestureRecognizer alloc]init];
        _hideKeyboardGesture.delegate = self;
    }
    return _hideKeyboardGesture;
}



@end

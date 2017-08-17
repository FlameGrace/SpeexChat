//
//  MessageViewController.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>

#import "ChatViewController.h"
#import "ChatInputView.h"
#import "ChatRecordView.h"
#import "OggSpeexManager.h"


@interface ChatViewController ()<ChatInputViewDelegate,UIGestureRecognizerDelegate,ChatViewDelegate>
{
    //在第一次进入页面时，视图应滑动到底部，而viewDidLayoutSubviews会调用多次，所以需要标记
    BOOL isViewLoaded;
}

@property (assign, nonatomic) ChatSource source;
@property (strong, nonatomic) ChatRecordView *chatView;
@property (strong, nonatomic) ChatInputView *inputView;
@property (strong , nonatomic) NSLayoutConstraint *chatViewBottomCon;
//给tableView添加的可以隐藏键盘的滑动手势
@property (strong, nonatomic) UIPanGestureRecognizer *hideKeyboardGesture;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.person.nickName;
    self.source = ChatSourceMe;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(switchPerson:)];
    [self chatView];
    [self inputView];
    [self.chatView.tableView reloadData];
    //第一次加载数据源
    [self.chatView loadMessagesFirst];
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [[OggSpeexManager shareInstance]stopPlaying];
    [[OggSpeexManager shareInstance]cancelRecording];
}

- (void)dealloc
{
    [self disObserveNotifycations];
}

- (void)switchPerson:(id)sender
{
    if(self.source == ChatSourceMe)
    {
        self.source = ChatSourceOther;
    }
    else
    {
        self.source = ChatSourceMe;
    }
}

#pragma ChatView Delegate

- (void)chatView:(ChatView *)chatView  needResendModel:(ChatModel *)model
{
    [self sendMessage:(ChatModel *)model];
}


#pragma 滑动隐藏键盘
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [self.view endEditing:YES];
    return NO;
}

#pragma 输入代理，开始语音输入
- (void)inputStartVoice
{
    [self.chatView scrollToBottomAnimation:NO];
}
- (void)inputTypeSwitched
{
    [self.chatView scrollToBottomAnimation:NO];
}
#pragma 输入代理，接收到一条输入
- (void)inputSendNewMessage:(ChatModel *)message
{
    message.source = self.source;
    message.isSendSuccess = YES;
    message.personId = self.person.personId;
    if([self.chatView.modelManager createNewManagedObjectByModel:message])
    {
        self.chatView.loadOffset += 1;
    }
    [self.chatView insertNewModel:message];
    [self sendMessage:message];
    
}

//发送消息
- (void)sendMessage:(ChatModel *)message
{
}
#pragma 接收到一键分享的通知
- (void)recieveNewMessageNotification:(NSNotification *)notification
{
    ChatModel *newMessage = notification.userInfo[RecievedNewChatMessageNotificationMessageKey];
    if(newMessage&&[newMessage isKindOfClass:[ChatModel class]]&&[newMessage.personId isEqualToString:self.person.personId])
    {
        if(newMessage.managedObjectID)
        {
            self.chatView.loadOffset += 1;
        }
        [self.chatView insertNewModel:newMessage];
    }
}


//当键盘显示时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    [self.chatView addGestureRecognizer:self.hideKeyboardGesture];
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *aDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardDuration = aDuration.floatValue;
    int height = keyboardRect.size.height;
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        self.chatViewBottomCon.constant = - height - 52;
    }
     completion:^(BOOL finished) {
         //直接执行有时会没有效果
         [self.chatView performSelector:@selector(scrollToBottomAnimation:) withObject:nil afterDelay:0];
     }];
    
}
//接收到清除消息记录的通知时
- (void)chatRemovedAllRecord
{
    [self.chatView loadMessagesFirst];
}


//当键盘退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [self.chatView removeGestureRecognizer:self.hideKeyboardGesture];
    NSDictionary *userInfo = [aNotification userInfo];
    NSNumber *aDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGFloat keyboardDuration = aDuration.floatValue;
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        self.chatViewBottomCon.constant = -52;
    }];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    [[OggSpeexManager shareInstance]stopPlaying];
    [[OggSpeexManager shareInstance]cancelRecording];
}



- (void)popToPrevPage
{

    [self.navigationController popViewControllerAnimated:YES];
}



- (void)observeNotifycations
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveNewMessageNotification:) name:RecievedNewChatMessageNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chatRemovedAllRecord) name:ChatRemovedAllRecordNotification object:nil];
    
}

- (void)disObserveNotifycations
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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


- (ChatRecordView *)chatView
{
    if(!_chatView)
    {
        _chatView = [[ChatRecordView alloc]init];
        _chatView.person = self.person;
        _chatView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_chatView];
        _chatView.delegate = self;
        _chatView.backgroundColor = [UIColor lightGrayColor];
        self.chatViewBottomCon = [NSLayoutConstraint constraintWithItem:_chatView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-52];
        [self.view addConstraint:self.chatViewBottomCon];
        [_chatView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64);
            make.width.equalTo(self.view);
            make.centerX.equalTo(self.view);
        }];

    }
    return _chatView;
}


- (ChatInputView *)inputView
{
    if(!_inputView)
    {
        _inputView = [[ChatInputView alloc]init];
        _inputView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_inputView];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.delegate = self;
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.chatView.mas_bottom);
            make.width.equalTo(self.view);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@52);
        }];
    }
    return _inputView;
}

@end

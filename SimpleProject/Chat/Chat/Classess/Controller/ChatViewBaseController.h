//
//  LMMessageViewController.h
//  Flame Grace
//
//  Created by lijj on 2017/2/24.
//  Copyright © 2017年 Flame Grace. All rights reserved.

#import <UIKit/UIKit.h>
#import "ChatGroupModelProtocol.h"
#import "ChatView.h"
#import "OggSpeexManager.h"

@interface ChatViewBaseController : UIViewController<UIGestureRecognizerDelegate,ChatViewDelegate>
{
    //在第一次进入页面时，视图应滑动到底部，而viewDidLayoutSubviews会调用多次，所以需要标记
    BOOL isViewLoaded;
}

@property (strong, nonatomic) id <ChatGroupModelProtocol> group;
@property (strong, nonatomic) ChatView *chatView;
//给tableView添加的可以隐藏键盘的滑动手势
@property (strong, nonatomic) UIPanGestureRecognizer *hideKeyboardGesture;

- (void)reloadChatList;

- (void)keyboardWillShow:(CGFloat)duration height:(CGFloat)height;

- (void)keyboardWillHide:(CGFloat)duration;

- (void)recieveAnNewChatGroupMessageNotification:(NSNotification *)notification;

- (void)removeAllChatGroupMessagesNotification:(NSNotification *)notification;

- (void)applicationDidEnterBackground:(NSNotification *)notification;

@end

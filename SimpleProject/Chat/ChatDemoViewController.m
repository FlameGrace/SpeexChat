//
//  ChatDemoViewController.m
//  Chat
//
//  Created by MAC on 2018/5/16.
//  Copyright © 2018年 Flame Grace. All rights reserved.
//

#import "ChatDemoViewController.h"
#import "ChatGroupMemberModelManager.h"

@interface ChatDemoViewController ()

@property (assign, nonatomic) ChatSource source;

@end

@implementation ChatDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(switchPerson:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)chatInputHandle:(id<ChatInputHandleProtocol>)handle inputAnNewChatMessage:(ChatModel *)model
{
    model.source = self.source;
    model.isSendSuccess = YES;
    model.group = self.group;
    if(self.source == ChatSourceOther)
    {
        model.person = self.getAnPerson;
    }
    [self.chatView insertNewModel:model];
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

- (ChatPersonModel *)getAnPerson
{
    ChatGroupMemberModelManager *memberManager = [ChatGroupMemberModelManager manager];
    NSArray *ar = [memberManager queryByGroupId:self.group.groupId];
    NSInteger index = rand()%ar.count;
    ChatGroupMemberModel *model = ar[index];
    return model.person;
}


@end

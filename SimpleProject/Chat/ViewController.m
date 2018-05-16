//
//  ViewController.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 . All rights reserved.
//

#import "ViewController.h"
#import "ChatGroupTableViewCell.h"
#import "ChatGroupModelManager.h"
#import "ChatGroupMemberModelManager.h"
#import "ChatDemoViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ViewController

static NSString *cellIdentifier = @"ChatGroupTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateTableView];
}

- (void)updateTableView
{
    ChatGroupModelManager *manager = [ChatGroupModelManager manager];
    self.dataSource = [manager queryAllSortByUpateTimeWithAccountID:AccountID];
    [self.tableView reloadData];
}

- (IBAction)addPerson:(id)sender {
    
    NSInteger personNumber = rand()%100;
    NSInteger avtar = personNumber%16;
    NSString *personId = [NSString stringWithFormat:@"%ld",(long)personNumber];
    NSString *avatarImageName = [NSString stringWithFormat:@"%ld",(long)avtar];
    ChatPersonModel *person = [[ChatPersonModel alloc]init];
    person.personId = personId;
    person.nickName = personId;
    person.accountID = AccountID;
    person.avatarImage = avatarImageName;
    if(![ChatPersonModelManager queryByPersonId:personId accountID:AccountID])
    {
        ChatPersonModelManager *personManager = [ChatPersonModelManager manager];
        [personManager createNewManagedObjectByModel:person];
    }
    
    ChatGroupModel *group = [[ChatGroupModel alloc]init];
    group.groupId = personId;
    group.groupName = personId;
    group.groupImage = avatarImageName;
    group.groupType = SingleChat;
    group.accountID = AccountID;
    group.updateTime = [NSDate date];
    if([ChatGroupModelManager queryByGroupId:group.groupId accountID:AccountID])
    {
        return;
    }
    ChatGroupModelManager *groupManager = [ChatGroupModelManager manager];
    [groupManager createNewManagedObjectByModel:group];
    [groupManager addMember:person toGroup:group];
    [self updateTableView];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatGroupModel *group = self.dataSource[indexPath.row];
    ChatDemoViewController *vc = [[ChatDemoViewController alloc]init];
    vc.group = group;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatGroupModel *group = self.dataSource[indexPath.row];
    ChatGroupTableViewCell *cell = (ChatGroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ChatGroupTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell updateByGroup:group];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end

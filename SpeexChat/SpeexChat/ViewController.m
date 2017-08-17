//
//  ViewController.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/24.
//  Copyright © 2017年 . All rights reserved.
//

#import "ViewController.h"
#import "ChatPersonTableViewCell.h"
#import "ChatPersonModelManager.h"
#import "ChatViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ViewController

static NSString *cellIdentifier = @"ChatPersonTableViewCell";

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
    ChatPersonModelManager *manager = [ChatPersonModelManager manager];
    self.dataSource = [manager queryAll];
    [self.tableView reloadData];
}

- (IBAction)addPerson:(id)sender {
    
    NSInteger personNumber = rand()%100;
    NSInteger avtar = personNumber%16;
    NSString *personId = [NSString stringWithFormat:@"%ld",(long)personNumber];
    ChatPersonModel *person = [[ChatPersonModel alloc]init];
    person.personId = personId;
    person.nickName = personId;
    person.avatarImage = [NSString stringWithFormat:@"%ld",(long)avtar];
    if([ChatPersonModelManager queryByPersonId:personId])
    {
        return;
    }
    ChatPersonModelManager *manager = [ChatPersonModelManager manager];
    [manager createNewManagedObjectByModel:person];
    [self updateTableView];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatPersonModel *person = self.dataSource[indexPath.row];
    ChatViewController *vc = [[ChatViewController alloc]init];
    vc.person = person;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatPersonModel *person = self.dataSource[indexPath.row];
    ChatPersonTableViewCell *cell = (ChatPersonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ChatPersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell updateByPerson:person];
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

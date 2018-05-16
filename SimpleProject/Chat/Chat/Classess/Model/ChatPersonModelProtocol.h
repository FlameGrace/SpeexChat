//
//  ChatPersonModelProtocol.h
//  SpeexChat
//
//  Created by 李嘉军 on 2017/11/23.
//  Copyright © 2017年 leapmotor. All rights reserved.
// 聊天对象定义

#import <Foundation/Foundation.h>

@protocol ChatPersonModelProtocol <NSObject>

//账户ID
@property (copy, nonatomic) NSString *accountID;
@property (strong, nonatomic) NSString *personId;
@property (strong, nonatomic) NSString *avatarImage;
@property (strong, nonatomic) NSString *nickName;

@end

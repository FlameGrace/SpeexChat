//
//  ChatPersonModel.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataModelProtocol.h"


@interface ChatPersonModel : NSObject <CoreDataModelProtocol>

@property (strong, nonatomic) NSString *personId;
@property (strong, nonatomic) NSString *avatarImage;
@property (strong, nonatomic) NSString *nickName;
@property (nonatomic, assign) NSInteger noReadNumber;

@end

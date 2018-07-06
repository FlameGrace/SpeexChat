//
//  ChatViewProtocol.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatTableViewCellProtocol.h"
#import "ChatModelProtocol.h"

@protocol ChatViewDelegate;

@protocol ChatViewProtocol <NSObject>

@property (weak, nonatomic) id<ChatViewDelegate> delegate;


@end


@protocol ChatViewDelegate <ChatTableViewCellDelegate>

@optional
- (UITableViewCell <ChatTableViewCellProtocol> *)customCellForModel:(id<ChatModelProtocol>)model;

@end

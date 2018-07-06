//
//  CarMessageCancelView.h
//  Flame Grace
//
//  Created by lijj on 2017/2/27.
//  Copyright © 2017年 Flame Grace. All rights reserved.
// 聊天消息提示框，大小（112，112）， 图片默认大小（44，44） 文字默认大小16，距底部间距18；

#import <UIKit/UIKit.h>

@interface ChatAlertView : UIView
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *tipLabel;


- (void)setTipText:(NSString *)tipText;

- (void)setTitleText:(NSString *)titleText;

- (void)setImage:(UIImage *)image imageSize:(CGSize)imageSize;

@end

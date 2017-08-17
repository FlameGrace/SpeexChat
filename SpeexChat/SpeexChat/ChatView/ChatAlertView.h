//
//  CarMessageCancelView.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// 聊天消息提示框，大小（112，112）， 图片默认大小（44，44） 文字默认大小16，距底部间距18；

#import <UIKit/UIKit.h>

@interface ChatAlertView : UIView

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *imageView;



- (void)setTitleColor:(UIColor *)color;

- (void)setImage:(UIImage *)image imageSize:(CGSize)imageSize;

- (void)hideImageView:(BOOL)show ;

@end

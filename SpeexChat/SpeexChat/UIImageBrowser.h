//
//  UIImageBrowser.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/17.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// 图片查看器，默认在window上添加一个全屏图片，点击自动隐藏，可缩放和移动
#import <Foundation/Foundation.h>


//注意：使用此类生成的对象必须一直持有该对象，不然会被自动释放
@interface UIImageBrowser : NSObject
@property (readonly, nonatomic) UIImageView *originView;
@property (strong, nonatomic) UIScrollView *backGroundView;
@property (strong, nonatomic) UIImageView *imageView;
//展示图片，自带动画，图片会从原位置移动到屏幕中心
//hideCompleteBlock：图片查看器被移除后的回调，可在此回调后释放该对象
- (void)showImageView:(UIImageView *)originView hideCompleteBlock:(VoidBlock )hideCompleteBlock;

//展示图片
//hideCompleteBlock：图片查看器被移除后的回调，可在此回调后释放该对象
- (void)showImage:(UIImage *)originImage hideCompleteBlock:(VoidBlock )hideCompleteBlock;

@end

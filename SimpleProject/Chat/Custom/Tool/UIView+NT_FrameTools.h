//
//  UIView+FrameTools.h
//  leapmotor
//
//  Created by lijj on 16/9/14.
//  Copyright © 2016年 leapmotor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NT_Tools)

@property (nonatomic,assign) double x;
@property (nonatomic,assign) double y;

@property (nonatomic,assign) double centerX;
@property (nonatomic,assign) double centerY;

@property (nonatomic,assign) double width;
@property (nonatomic,assign) double height;

@property (nonatomic,assign,readonly) CGPoint left_top_point;
@property (nonatomic,assign,readonly) CGPoint right_top_point;
@property (nonatomic,assign,readonly) CGPoint left_bottom_point;
@property (nonatomic,assign,readonly) CGPoint right_bottom_point;

- (CGRect)mainScreenBounds;

- (CGFloat)mainScreenWidth;

- (CGFloat)mainScreenHeight;

@end

//
//  UIView+FrameTools.m
//  Flame Grace
//
//  Created by lijj on 16/9/14.
//  Copyright © 2016年 Flame Grace. All rights reserved.
//

#import "UIView+NT_FrameTools.h"

@implementation UIView (NT_FrameTools)

- (CGRect)mainScreenBounds
{
    return [UIScreen mainScreen].bounds;
}

- (CGFloat)mainScreenWidth
{
    return self.mainScreenBounds.size.width;
}

- (CGFloat)mainScreenHeight
{
    return self.mainScreenBounds.size.height;
}

- (double)x {
    return self.frame.origin.x;
}

- (void)setX:(double)x {
    [self setFrame_Origin_x:x];
}

- (double)y {
    return self.frame.origin.y;
}

- (void)setY:(double)y {
    [self setFrame_Origin_y:y];
}

- (double)centerX
{
    return self.center.x;
}

- (double)centerY
{
    return self.center.y;
}

-(void)setCenterX:(double)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(void)setCenterY:(double)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (double)width {
    return self.frame.size.width;
}

- (void)setWidth:(double)width {
    [self setFrame_Size_Width:width];
}

- (double)height {
    return self.frame.size.height;
}

- (void)setHeight:(double)height {
    [self setFrame_Size_Height:height];
}

- (void)setFrame_Origin_x:(double)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setFrame_Origin_y:(double)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setFrame_Size_Width:(double)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setFrame_Size_Height:(double)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)left_top_point {
    CGPoint point;
    point.x = self.x;
    point.y = self.y;
    return point;
}

- (CGPoint)left_bottom_point {
    CGPoint point;
    point.x = self.x;
    point.y = self.y + self.height;
    return point;
}

- (CGPoint)right_top_point {
    CGPoint point;
    point.x = self.x + self.width;
    point.y = self.y;
    return point;
}

- (CGPoint)right_bottom_point {
    CGPoint point;
    point.x = self.x + self.width;
    point.y = self.y + self.height;
    return point;
}

@end

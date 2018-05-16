//
//  UIView+ClearSystemGestureEffect.m
//  AFNetworking
//
//  Created by MAC on 2018/5/16.
//

#import "UIView+ClearSystemGestureEffect.h"

@implementation UIView (ClearSystemGestureEffect)

- (void)clearSystemGestureEffect
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        for (UIGestureRecognizer *gesture in window.gestureRecognizers) {
            //系统手势识别过程中不打断Touch时间的传递，用处：
            //1. 可防止touch事件延迟（实测有TableView时延迟高达0.8s）
            //2. 可防止Touch事件被系统手势捕获，即时被捕获，也能正常收到touchCanceled的回调
            gesture.delaysTouchesBegan = NO;
            gesture.delaysTouchesEnded = NO;
        }
    }
}

@end

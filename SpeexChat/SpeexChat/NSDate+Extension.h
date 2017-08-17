//
//  NSDate+Extension.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/9/29.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
//与otherDate的时分秒相减
- (NSTimeInterval)justReduceTimeToDate:(NSDate *)otherDate;
//比对是否为同一天的日期
- (BOOL)isDayEqualToDate:(NSDate *)otherDate;
//判断是否是昨天的日期
- (BOOL)isYesterday;
//判断是否为昨天的日期
- (BOOL)isToday;


@end

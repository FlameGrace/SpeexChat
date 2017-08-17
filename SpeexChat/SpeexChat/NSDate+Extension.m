//
//  NSDate+Extension.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/9/29.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSTimeInterval)justReduceTimeToDate:(NSDate *)otherDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm:ss"];
    NSString *this = [df stringFromDate:self];
    NSString *other = [df stringFromDate:otherDate];
    
    this = [NSString stringWithFormat:@"2016-12-11 %@",this];
    other = [NSString stringWithFormat:@"2016-12-11 %@",other];
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *thisTime = [df dateFromString:this];
    NSDate *otherTime = [df dateFromString:other];
    
    NSTimeInterval reduce = thisTime.timeIntervalSince1970 - otherTime.timeIntervalSince1970;

    return reduce;
}

- (BOOL)isToday
{
    return [self isDayEqualToDate:[NSDate date]];
}

- (BOOL)isDayEqualToDate:(NSDate *)otherDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy/MM/dd"];
    NSString *current = [df stringFromDate:self];
    NSString *other = [df stringFromDate:otherDate];
    return [current isEqualToString:other];
}

- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDay = [df stringFromDate:now];
    NSDate *date = [df dateFromString:currentDay];
    NSTimeInterval dateTimeStamp = [date timeIntervalSince1970];
    NSTimeInterval timeStamp = [self timeIntervalSince1970];
    if(timeStamp <dateTimeStamp && timeStamp >= dateTimeStamp - 24*60*60)
    {
        return YES;
    }
    return NO;
}

@end

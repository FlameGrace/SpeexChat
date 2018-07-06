//
//  NSDate+Extension.m
//  Flame Grace
//
//  Created by Flame Grace on 16/9/29.
//  Copyright © 2016年 Flame Grace. All rights reserved.
//

#import "NSDate+NT_Extension.h"

@implementation NSDate (NT_Extension)

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

//
//  NSString+Extension.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFontAttributes:(NSDictionary *)attributes andMaxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}


- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont*)font constraintSize:(CGSize)constraintSize
{
    CGSize stringSize = CGSizeZero;
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    CGRect stringRect = [self boundingRectWithSize:constraintSize options:options attributes:attributes context:NULL];
    stringSize = stringRect.size;
    
    return stringSize;
}


+ (NSString *)pinyinForString:(NSString *)string combiningMarks:(BOOL)strip
{
    NSMutableString *pinyin = [string mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    if(strip)return pinyin;
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}


+ (NSDictionary *)getDicFromJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    if([jsonString isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dic = (NSDictionary *)jsonString;
        return dic;
    }
    if(![jsonString isKindOfClass:[NSString class]]) return nil;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end

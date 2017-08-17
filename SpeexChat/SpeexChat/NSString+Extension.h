//
//  NSString+Extension.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
*  返回值是该字符串所占的大小(width, height)
*
*  @param attributes 该字符串所用的字体属性(字体大小不一样,显示出来的面积也不同)
*  @param maxSize    为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
*
*  @return 返回值是该字符串所占的大小(width, height)
*/
- (CGSize)sizeWithFontAttributes:(NSDictionary *)attributes andMaxSize:(CGSize)maxSize;


/**
 *  返回值是该字符串所占的大小(width, height)
 *
 *  @param font 字体
 *  @param maxSize    为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 *
 *  @return 返回值是该字符串所占的大小(width, height)
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont*)font constraintSize:(CGSize)constraintSize;

/**
 *  返回中文拼音
 *
 *  @param string 中文字符串
 *  @param strip    是否带音标
 *
 *  @return 返回值是中文拼音
 */

+ (NSString *)pinyinForString:(NSString *)string combiningMarks:(BOOL)strip;
/**
 *  json字符串解析
 */
+ (NSDictionary *)getDicFromJsonString:(NSString *)jsonString;

@end

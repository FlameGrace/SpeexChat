//
//  NSFileManager+Tools.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/5.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Tools)

- (BOOL)removeTheItemAtPath:(NSString *)path fileManager:(NSFileManager*)manager;

/**
 获取本地文件信息

 @param localFilePath 本地文件路径
 @param error 获取出错
 @return 文件信息的字典
 */
+ (NSDictionary *)fileInfo:(NSString *)localFilePath error:(NSError **)error;


/**
 生成可描述的文jian大小

 @param fileSize 文件大小
 @return 例如1.1B,2.2K,3.3M,4.4G,5.5T等描述
 */
+ (NSString *)descriptionForFileSize:(float)fileSize;

/**
 获取文件夹大小 (单位 b)
 @param folderPath 文件夹
 @return 文件夹大小
 */
+ (float)folderSizeAtPath:(NSString*)folderPath;

/**
 获取本地文件的大小

 @param localFilePath 本地文件路径
 @return 文件大小。为-1则说明获取失败
 */
+ (float)fileSize:(NSString *)localFilePath;

/**
 沙盒路径
 */
+ (NSString *)documentPath;

/**给相对路径追加doucment路径前缀，获取完整路径
 @param relativePath 相对于document的路径
 @return 完整路径
 */
+ (NSString *)documenFullPath:(NSString *)relativePath;

+ (NSString *)chatRelativePath:(NSString *)fileName;

@end

//
//  NSFileManager+Tools.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/12/5.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "NSFileManager+Tools.h"

@implementation NSFileManager (Tools)

- (BOOL)removeTheItemAtPath:(NSString *)path fileManager:(NSFileManager*)manager {
    BOOL result;
    NSError *error;
    if ([manager fileExistsAtPath:path]) {
        result = [manager removeItemAtPath:path error:&error];
        return result;
    } else {
        result = NO;
    }
    return result;
}

+ (NSString *)descriptionForFileSize:(float)fileSize
{
    if(fileSize/1024.0 <1)
    {
        NSString *b = [NSString stringWithFormat:@"%.1fB",fileSize];
        return b;
    }
    if(fileSize/(1024.0*1024.0) <1)
    {
        NSString *k = [NSString stringWithFormat:@"%.1fK",fileSize/1024.0];
        return k;
    }
    if(fileSize/(1024.0*1024.0*1024.0) <1)
    {
        NSString *m = [NSString stringWithFormat:@"%.1fM",fileSize/(1024.0*1024.0)];
        return m;
    }
    if(fileSize/(1024.0*1024.0*1024.0*1024) <1)
    {
        NSString *g = [NSString stringWithFormat:@"%.1fG",fileSize/(1024.0*1024.0*1024.0)];
        return g;
    }
    NSString *g = [NSString stringWithFormat:@"%.1fT",fileSize/(1024.0*1024.0*1024.0*1024.0)];
    return g;
}

+ (NSDictionary *)fileInfo:(NSString *)localFilePath error:(NSError **)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *dic = [fileManager attributesOfItemAtPath:localFilePath error:error];
    
    return dic;
}

+ (float)folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    float folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSize:fileAbsolutePath];
    }
    return folderSize;
}

+ (float)fileSize:(NSString *)localFilePath
{
    NSDictionary *dic = [self fileInfo:localFilePath error:nil];
    NSNumber *fileSize = [dic objectForKey:NSFileSize];
    if(!fileSize)
    {
        return -1;
    }
    return fileSize.floatValue;
}

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
//    Log(UnKnow,@"Document:%@",docDir);
    return docDir;
}

+ (NSString *)documenFullPath:(NSString *)relativePath
{
    return [[self documentPath]stringByAppendingPathComponent:relativePath];
}

+ (NSString *)chatRelativePath:(NSString *)fileName
{
    NSString *path = @"chat";
    NSString *fullPath = [[self documentPath]stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
    if(!isExist || !isDir)
    {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:NO attributes:nil error:&error];
        if(error)
        {
            NSLog(@"文件夹目录chat创建失败：%@",error);
        }
    }
    NSString *relativePath = [path stringByAppendingPathComponent:fileName];
    return relativePath;
}



@end

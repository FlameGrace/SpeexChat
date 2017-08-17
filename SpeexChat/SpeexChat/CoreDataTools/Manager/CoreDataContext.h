//
//  CoreDataContext.h
//  manydb
//
//  Created by Flame Grace on 16/10/18.
//  Copyright © 2016年 hello. All rights reserved.
//  可以切换数据库

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



#define Default_ModeldName @"Chat"

@interface CoreDataContext : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


//共享单例，context指向默认文件名的XCDataModeld文件
+ (instancetype)sharedContext;


//context指向给定文件名的XCDataModeld文件
- (id)initWithXCDataModeldName:(NSString *)modeldName;

- (void)saveContext;

@end

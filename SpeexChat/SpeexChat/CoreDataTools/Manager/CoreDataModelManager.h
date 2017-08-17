//
//  CoreDataManager.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/31.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataModelManagerProtocol.h"

// CoreData数据管理类的基类，主要针对特定实体实现保存Model数据到CoreData,从CoreData查询数据，删除数据的功能
// 实现Model与NSManagedObject的分离
@interface CoreDataModelManager : NSObject <CoreDataModelManagerProtocol>

+ (instancetype)manager;

// 默认为共享单例所指managedContext，也可重新赋值，可用于切换数据库
@property (strong, nonatomic)NSManagedObjectContext * managedContext;

// 将NSManagedObject对象的集合转换为相应实体的Model对象的数组
- (NSMutableArray <id<CoreDataModelProtocol>> *)getModelsFromManagedObjects:(NSArray <NSManagedObject *> *)managedObjects;

// 删除一条数据
- (BOOL)removeManagedObject:(NSManagedObjectID *)managedObjectID;

- (BOOL)removeAll;

// 将结果保存到CoreData
- (BOOL)save;

// 将一个Model对象转换成NSManagedObject，再更新到CoreData中
- (BOOL)update:(id<CoreDataModelProtocol>)model;

// 根据一个Model对象在CoreData中创建一条数据
- (BOOL)createNewManagedObjectByModel:(id<CoreDataModelProtocol>)model;

// 查询一个实体里的所有数据
- (NSMutableArray <id<CoreDataModelProtocol>> *)queryAll;

// 条件查询
- (NSMutableArray <id<CoreDataModelProtocol>> *)queryWithPredicateFormat:(NSString *)format value:(id)value;

// 条件查询，并根据条件排序
- (NSMutableArray <id<CoreDataModelProtocol>> *)queryWithPredicateFormat:(NSString *)format value:(id)value sortKey:(NSString *)sortKey asc:(BOOL)asc;

// 条件查询，并根据条件排序,分页查询
- (NSMutableArray <id<CoreDataModelProtocol>> *)queryWithPredicateFormat:(NSString *)format value:(id)value sortKey:(NSString *)sortKey asc:(BOOL)asc limit:(NSInteger)limit offset:(NSInteger)offset;

@end

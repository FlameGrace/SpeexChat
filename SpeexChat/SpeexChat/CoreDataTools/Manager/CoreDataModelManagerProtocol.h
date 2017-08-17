//
//  CoreDataManagerProtocol.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/31.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataModelProtocol.h"

// CoreData管理类的协议
@protocol CoreDataModelManagerProtocol <NSObject>

// 子类必须定义要管理的实体名称
- (NSString *)entityName;

// 必须在每个子类重写将NSManagedObject数据更新到Model的方法
- (void)updateModel:(id<CoreDataModelProtocol>)model byManagedObject:(NSManagedObject *)managedObject;

// 必须在每个子类重写将Model数据更新到NSManagedObject的方法
- (void)updateManagedObject:(NSManagedObject *)managedObject byModel:(id<CoreDataModelProtocol>)model;

// 必须在每个子类重写将NSManagedObject转换成到Model的方法
- (id<CoreDataModelProtocol>)getModelFromManagedObject:(NSManagedObject *)managedObject;

@end

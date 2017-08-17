//
//  LMCoreDataModel.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/31.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataModelProtocol.h"

// CoreData NSManagedObject转换后模型基类
@interface CoreDataModel : NSObject <CoreDataModelProtocol>

+ (instancetype)model;

@end

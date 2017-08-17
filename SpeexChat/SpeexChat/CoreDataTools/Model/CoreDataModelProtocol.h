//
//  CoreDataModelProtocol.h
//  SpeexChat
//
//  Created by Flame Grace on 2017/7/25.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <CoreData/CoreData.h>

@protocol CoreDataModelProtocol <NSObject>

// 保存对应的NSManagedObject对象的ID
@property (nonatomic, strong) NSManagedObjectID *managedObjectID;

@end

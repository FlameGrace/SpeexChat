//
//  LMCoreDataModel.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/8/31.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "CoreDataModel.h"


@implementation CoreDataModel

@synthesize managedObjectID = _managedObjectID;

+ (instancetype)model
{
    return [[self alloc]init];
}


@end

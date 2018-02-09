//
//  SortClass.h
//  Test
//
//  Created by Xiong on 2018/2/8.
//  Copyright © 2018年 Xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SortType)
{
    SortTypeBubble = 1,
    SortTypeInsert,
    SortTypeShell,
    SortTypeSimple,
    SortTypeHeap,
    SortTypeMerging,
    SortTypeQuick,
    SortTypeRadix,
};


@interface SortClass : NSObject

+ (void)sortWithType:(SortType)type array:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock;

@end

//
//  SortClass.m
//  Test
//
//  Created by Xiong on 2018/2/8.
//  Copyright © 2018年 Xiong. All rights reserved.
//

#import "SortClass.h"

@implementation SortClass



+ (void)sortWithType:(SortType)type array:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    switch (type) {
        case SortTypeBubble:
        {
            [self bubbleSortWithArray:array handleBlock:handleBlock];
        }
            break;
        case SortTypeInsert:
        {
            [self insertSortWithArray:array handleBlock:handleBlock];
        }
            break;
        case SortTypeShell:
        {
            [self shellSortWithArray:array handleBlock:handleBlock];
        }
            break;
        case SortTypeSimple:
        {
            [self simpleSortWithArray:array handleBlock:handleBlock];
        }
            break;
        case SortTypeHeap:
        {
            [self heapSortWithArray:array handleBlock:handleBlock];
        }
            break;
        case SortTypeMerging:
        {
            [self mergingSortWithArray:array handleBlock:handleBlock];
        }
            break;
        case SortTypeQuick:
        {
            [self quickSortWithArray:array handleBlock:handleBlock];
        }
            break;
        case SortTypeRadix:
        {
            [self radixSortWithArray:array handleBlock:handleBlock];
        }
            break;
        default:
            break;
    }
}

#pragma mark -  冒泡排序-O(n^2)
+ (NSMutableArray *)bubbleSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    NSMutableArray *list = array;
    for (int i = 0; i< array.count; i++) {
        int j = (int)array.count -1;
        while (j > i) {
            if ([array[j-1] integerValue] > [array[j] integerValue]) {
                
                NSNumber *temp = array[j];
                array[j] = array[j-1];
                array[j-1] = temp;
                
                if (handleBlock) {
                    handleBlock(j, [array[j] integerValue]);
                    handleBlock(j-1, [array[j-1] integerValue]);
                }
            }
            j = j-1;
        }
    }
    return list;
}

#pragma mark -  插入排序-O(n^2)
+ (NSMutableArray *)insertSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    //print("插入排序")
    NSMutableArray *list = array;
    for (int i = 0; i< array.count; i++) {   //循环无序数列
        //print("第\(i)轮插入：")
        //print("要选择插入的值为：\(list[i])")
        int j = i;
        while (j > 0) {           //循环有序数列，插入相应的值
            if ([list[j] integerValue] < [list[j - 1] integerValue] ) {
                
                NSNumber *temp = array[j];
                array[j] = array[j-1];
                array[j-1] = temp;
                
                if (handleBlock) {
                    handleBlock(j, [array[j] integerValue]);
                    handleBlock(j-1, [array[j-1] integerValue]);
                }
                
                j = j - 1;
            } else {
                break;
            }
        }
    }
    return list;
}


#pragma mark - 希尔排序：时间复杂度----O(n^(3/2))
+ (NSMutableArray *)shellSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    //print("希尔排序")
    NSMutableArray *list = array;
    int step = (int)list.count / 2;
    while (step > 0) {
        //print("步长为\(step)的插入排序开始：")
        for (int i = 0; i< array.count; i++) {
            int j = i + step;
            while (j >= step && j < list.count) {
                if ([list[j] integerValue] < [list[j - step] integerValue])  {
    
                    NSNumber *temp = array[j];
                    array[j] = array[j-step];
                    array[j-step] = temp;
                    
                    if (handleBlock) {
                        handleBlock(j, [array[j] integerValue]);
                        handleBlock(j-step, [array[j-step] integerValue]);
                    }
                    
                    j = j - step;
                } else {
                    break;
                }
            }
        }
        step = step / 2;     //缩小步长
    }
    return list;
}

#pragma mark -  简单选择排序－O(n^2)
//希尔排序：时间复杂度----O(n^(3/2))
+ (NSMutableArray *)simpleSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    //print("简单选择排序")
    NSMutableArray *list = array;

    for (int i = 0; i< array.count; i++) {
        //print("第\(i+1)轮选择，选择下标的范围为\(i)----\(list.count)")
        int j = i + 1;
        NSInteger minValue = [list[i] integerValue];
        int minIndex = i;
        
        //寻找无序部分中的最小值
        while (j < list.count) {
            if (minValue > [list[j] integerValue]) {
                minValue = [list[j] integerValue];
                minIndex = j;
            }
            if (handleBlock) {
                handleBlock(j, [array[j] integerValue]);
            }
            j = j + 1;
        }
        //print("在后半部分乱序数列中，最小值为：\(minValue), 下标为：\(minIndex)")
        //与无序表中的第一个值交换，让其成为有序表中的最后一个值
        if (minIndex != i) {
            //print("\(minValue)与\(list[i])交换")
            NSNumber *temp = list[i];
            list[i] = list[minIndex];
            list[minIndex] = temp;
            
            if (handleBlock) {
                handleBlock(i, [array[i] integerValue]);
                handleBlock(minIndex, [array[minIndex] integerValue]);
            }
        }
        //print("本轮结果为：\(list)\n")
    }
    return list;
    
}

 
 
 
#pragma mark -  堆排序 (O(nlogn))
   //希尔排序：时间复杂度----O(n^(3/2))
+ (NSMutableArray *)heapSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    //print("希尔排序")
    NSMutableArray *list = array;
    int endIndex = (int)list.count - 1;
    
    //创建大顶堆，其实就是将list转换成大顶堆层次的遍历结果
    [self heapCreateWithArray:array handleBlock:handleBlock];
    
    //print("原始堆：\(list)")
    while (endIndex >= 0) {
        //将大顶堆的顶点（最大的那个值）与大顶堆的最后一个值进行交换
        //print("将list[0]:\(list[0])与list[\(endIndex)]:\(list[endIndex])交换")
        NSNumber *temp = list[0];
        list[0] = list[endIndex];
        list[endIndex] = temp;
        
        if (handleBlock) {
            handleBlock(0, [array[0] integerValue]);
            handleBlock(endIndex, [array[endIndex] integerValue]);
        }
        
        endIndex -= 1;   //缩小大顶堆的范围
        
        //对交换后的大顶堆进行调整，使其重新成为大顶堆
        [self heapAdjastWithArray:array startIndex:0 endIndex:endIndex+1 handleBlock:handleBlock];
    }
    return list;
}

 
 /// 构建大顶堆的层次遍历序列（f(i) > f(2i), f(i) > f(2i+1) i > 0）
+ (void)heapCreateWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    int i = (int)array.count;
    while (i > 0) {
        [self heapAdjastWithArray:array startIndex:i - 1 endIndex: (int)array.count handleBlock:handleBlock];
        i -= 1;
    }
}
 
 /// 对大顶堆的局部进行调整，使其该节点的所有父类符合大顶堆的特点
+ (void)heapAdjastWithArray:(NSMutableArray *)array startIndex:(int)startIndex endIndex:(int)endIndex handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    NSNumber *temp = array[startIndex];
    int fatherIndex = startIndex + 1;                 //父节点下标
    int maxChildIndex = 2 * fatherIndex;              //左孩子下标
    while (maxChildIndex <= endIndex) {
        //比较左右孩子并找出比较大的下标
        if (maxChildIndex < endIndex && [array[maxChildIndex-1] integerValue] < [array[maxChildIndex] integerValue]) {
            maxChildIndex = maxChildIndex + 1;
        }
        
        //如果较大的那个子节点比根节点大，就将该节点的值赋给父节点
        if (temp < array[maxChildIndex-1]) {
            array[fatherIndex-1] = array[maxChildIndex-1];
            if (handleBlock) {
                handleBlock(fatherIndex-1, [array[fatherIndex-1] integerValue]);
            }
        } else {
            break;
        }
        fatherIndex = maxChildIndex;
        maxChildIndex = 2 * fatherIndex;
    }
    array[fatherIndex-1] = temp;
    if (handleBlock) {
        handleBlock(fatherIndex-1, [array[fatherIndex-1] integerValue]);
    }
}

 
 
#pragma mark -  归并排序O(nlogn)
// var tempArray: Array<Array<Int>> = []
   //希尔排序：时间复杂度----O(n^(3/2))
+ (NSMutableArray *)mergingSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    //print("希尔排序")
    NSMutableArray *tempArray = [NSMutableArray array];
    //将数组中的每一个元素放入一个数组中
    for (NSNumber *item in array) {
        NSMutableArray *subArray = [NSMutableArray array];
        [subArray addObject:item];
        [tempArray addObject:subArray];
    }
    
    //对这个数组中的数组进行合并，直到合并完毕为止
    while (tempArray.count != 1) {
        int i = 0;
        while (i < tempArray.count - 1) {
            //print("将\(tempArray[i])与\(tempArray[i+1])合并")
            tempArray[i] = [self mergeArray:tempArray[i] secondArray:tempArray[i + 1]];
            [tempArray removeObjectAtIndex: i + 1];
            for (int subIndex = 0; subIndex < (int)([tempArray[i] count]); subIndex++) {
                int index = [self countSubItemIndex:i subItemIndex:subIndex array:tempArray];
                if (handleBlock) {
                    handleBlock(index, [tempArray[i][subIndex] integerValue]);
                }
            }
            i = i + 1;
        }
    }
    return tempArray.firstObject;
}

 
 /// 归并排序中的“并”--合并：将两个有序数组进行合并
 ///
 /// - parameter firstList:  第一个有序数组
 /// - parameter secondList: 第二个有序数组
 ///
 /// - returns: 返回排序好的数组
+ (NSMutableArray *)mergeArray:(NSMutableArray *)firstArray secondArray:(NSMutableArray *)secondArray
{
    NSMutableArray *resultList = [NSMutableArray array];
    int firstIndex = 0;
    int secondIndex = 0;
    
    while (firstIndex < firstArray.count && secondIndex < secondArray.count) {
        if ([firstArray[firstIndex] integerValue] < [secondArray[secondIndex] integerValue]) {
            [resultList addObject:firstArray[firstIndex]];
            firstIndex += 1;
        } else {
            [resultList addObject:secondArray[secondIndex]];
            secondIndex += 1;
        }
    }
    
    while (firstIndex < firstArray.count) {
        [resultList addObject:firstArray[firstIndex]];
        firstIndex += 1;
    }
    
    while (secondIndex < secondArray.count) {
        [resultList addObject:secondArray[secondIndex]];
        secondIndex += 1;
    }
    return resultList;
}

+ (int)countSubItemIndex:(int)endIndex subItemIndex:(int)subItemIndex array:(NSMutableArray *)array
{
    int sum = 0;
    for (int i = 0; i < endIndex; i++) {
        sum += [array[i] count];
    }
    
    return sum + subItemIndex;
}

 
 
#pragma mark - 快速排序O(nlogn)
+ (NSMutableArray *)quickSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    NSMutableArray *list = array;
    //print("快速排序开始：")
    [self quickSortWithList:list low:0 high:(int)list.count-1 handleBlock:handleBlock];
    //print("快速排序结束！")
    return list;
}


/// 快速排序
///
/// - parameter list: 要排序的数组
/// - parameter low: 数组的上界
/// - parameter high: <#high description#>
+ (void)quickSortWithList:(NSMutableArray *)list low:(int)low high:(int)high handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    if (low < high) {
        int mid = [self partitionWithList:list low:low high:high handleBlock:handleBlock];
        [self quickSortWithList:list low:low high: mid - 1 handleBlock:handleBlock]; //递归前半部分
        [self quickSortWithList:list low:mid + 1 high: high handleBlock:handleBlock]; //递归后半部分
    }
}

/// 将数组以第一个值为准分成两部分，前半部分比该值要小，后半部分比该值要大
///
/// - parameter list: 要二分的数组
/// - parameter low:  数组的下界
/// - parameter high: 数组的上界
///
/// - returns: 分界点

+ (int)partitionWithList:(NSMutableArray *)list low:(int)low high:(int)high handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    NSNumber *temp = list[low];
    //print("low[\(low)]:\(list[low]), high[\(high)]:\(list[high])")
    while (low < high) {
        
        while (low < high && [list[high] integerValue] >= temp.integerValue) {
            high -= 1;
        }
        list[low] = list[high];
        if (handleBlock) {
            handleBlock(low, [list[low] integerValue]);
        }
        while (low < high && [list[low] integerValue] <= temp.integerValue) {
            low += 1;
        }
        list[high] = list[low];
        if (handleBlock) {
            handleBlock(high, [list[high] integerValue]);
        }
    }
    list[low] = temp;
    if (handleBlock) {
        handleBlock(low, [list[low] integerValue]);
    }
    return low;
}

#pragma mark - 基数排序
//class RadixSort: SortBaseClass, SortType {
+ (void)radixSortWithArray:(NSMutableArray *)array handleBlock:(void(^)(NSInteger index, NSInteger height))handleBlock
{
    NSMutableArray *bucket = [self createBucket];
    NSNumber *maxNumber = [self listMaxItem:array];
    int maxLength = [self numberLength:maxNumber];
    
    for (int digit = 1; digit <= maxLength; digit++) {
        //入桶
        
        for(NSNumber *item in array) {
            int baseNumber = [self fetchBaseNumber:item digit:digit];
            [bucket[baseNumber] addObject:item]; //根据基数入桶
        }
        //出桶
        int index = 0;
        for (int i = 0; i<bucket.count; i++) {
            
            while ([bucket[i] count]>0) {
                
                array[index] = [bucket[i] firstObject];
                
                [bucket[i] removeObjectAtIndex:0];
                
                if (handleBlock) {
                    handleBlock(index, [array[index] integerValue]);
                }
                index += 1;
            }
        }
    }
}
    
/// 创建10个桶
///
/// - returns: 返回创建好的桶子
+ (NSMutableArray *)createBucket
{
    NSMutableArray *bucket = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {

        [bucket addObject:[NSMutableArray array]];
    }
    return bucket;
}


/// 计算序列中最大的那个数
///
/// - parameter list: 数列
///
/// - returns: 返回该数列中最大的值
+ (NSNumber *)listMaxItem:(NSMutableArray *)list
{
    NSNumber *maxNumber = list[0];
    for (NSNumber *item in list) {
        if (maxNumber.integerValue < item.integerValue) {
            maxNumber = item;
        }
    }
    return maxNumber;
}



    
    
/// 获取相应位置的数字
///
/// - parameter number: 操作的数字
/// - parameter digit:  位数
///
/// - returns: 返回该位数上的数字
+ (int)fetchBaseNumber:(NSNumber *)number digit:(int)digit
{
    if (digit > 0 && digit <= [self numberLength:number]) {
        NSMutableArray *numbersArray = [NSMutableArray array];
        NSString *newStr = [NSString stringWithFormat:@"%@",@(number.integerValue)];
        
        for(int i =0; i < [newStr length]; i++)
        {
            NSString *temp = [newStr substringWithRange:NSMakeRange(i,1)];
            [numbersArray addObject:temp];
        }
        return [numbersArray[numbersArray.count - digit] intValue];
    }
    return 0;
}

/// 获取数字的长度
///
/// - parameter number: 该数字
///
/// - returns: 返回该数字的长度
+ (int)numberLength:(NSNumber *)number
{
    NSString *str = [NSString stringWithFormat:@"%@",@(number.integerValue)];
    return (int)str.length;
}
@end

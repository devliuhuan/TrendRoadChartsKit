//
//  NSArray+LTTool.h
//  TrendRoadChartsKitSample
//
//  Created by 独孤流 on 19/01/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
@interface NSArray (LTTool)
#pragma mark - 数组转换
/**
 数组转换
 将原始数组里的每一个元素转换成一个新的元素
 @param mapBlock 转换的block
 @return 转换好的数组
 */
- (NSArray *)lt_map:(id(^)(id obj))mapBlock;
#pragma mark 数组过滤
/**
 数组过滤
 返回是否要包含，返回YES要保留，返回NO不保留
 @param filterBlock 过滤回调block
 @return 筛选过的新数组
 */
- (NSArray *)lt_filter:(BOOL(^)(id obj))filterBlock;
/**
 将以前是包含字典的数组变成可变字典的可变数组
 Array<Dict>->MutalbalrArray<NSMutableDict>
 @return 可变字典的可变数组
 */
- (NSMutableArray *)lt_map2DictMArray;
#pragma mark 找数组内最大的值
/**
 在数组的指定范围内找最大的一个对象
 如果obj2>obj1，则返回obj2
 @param range 在数组的范围内
 @param maxBlock 比较block
 @return 返回找到的值
 */
- (id)lt_findMaxInRange:(NSRange)range block:(BOOL(^)(id obj1,id obj2))maxBlock;

/**
 晒选字典数组，一某个key的integerValue进行排序
 
 @param range 要筛选的范围
 @param key 进行判断的key
 @return 筛选完成后的内容
 */
- (id)lt_findMaxInRange:(NSRange)range key:(NSString *)key;
#pragma mark 创建有默认数据的数组
/**
 创建一个有填充内容的数组
 创建指定长度，并给每个位置都设置默认数据的数组
 @param count 数组长度
 @param fillBlock 填充默认数据的回调
 @return 创建好的数组
 */
+ (NSMutableArray *)lt_fillCount:(NSInteger)count fillBlock:(id(^)(NSInteger index))fillBlock;
+ (NSMutableArray *)lt_fillCount:(NSInteger)count fillObj:obj;
#pragma mark - 创建一个数字数组
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to;
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo;
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo tailArray:(NSArray *)tailArray;
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo prefix:(NSString *)prefix suffix:(NSString *)suffix;
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo prefix:(NSString *)prefix suffix:(NSString *)suffix tailArray:(NSArray *)tailArray;
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo suffix:(NSString *)suffix prefixArray:(NSArray *)prefixArray;
+ (NSMutableArray *)lt_addArray:(NSArray *)array;
- (NSMutableArray *)lt_insertArray:(NSArray *)array atIndex:(NSInteger)index;
#pragma mark - 判断素组是否包含只能内容
/**
 判断数组是否包含一格文本
 @param txt 需要比较包含的文本
 @param ignoreZero 是否忽略无意义的0
 @return 比较结果
 */
- (BOOL)lt_isContainsTxt:(NSString *)txt ignoreZero:(BOOL)ignoreZero;
#pragma mark 获取数组包含指定内容的数量
/**
 数组包含某个字符串的个数
 
 @param txt 需要比较的个数
 @param ignoreZero 是否忽略无意义的0
 @return 包含的个数
 */
- (NSInteger)lt_containsCountWithTxt:(NSString *)txt ignoreZero:(BOOL)ignoreZero;
#pragma mark - 截取指定范围的数据
/**
 从一个数组里截取一个子数组，如果需要截取的长度大于数据的长度，以数据长度为准
 
 @param range 要截取的位置
 @return 截取后返回的数组
 */
- (NSArray *)lt_subArrayWithRange:(NSRange)range;
#pragma mark - 将数组组装成一个属性字符串
- (NSAttributedString *)lt_attrTxtWithColor:(UIColor *)color range:(NSRange)range seperator:(NSString *)seperator;
- (NSAttributedString *)lt_attrTxtWithColor:(UIColor *)color redRange:(NSRange)redRange redColor:(UIColor *)redColor seperator:(NSString *)seperator;
@end

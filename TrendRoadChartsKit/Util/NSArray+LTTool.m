//
//  NSArray+LTTool.m
//  TrendRoadChartsKitSample
//
//  Created by 独孤流 on 19/01/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "NSArray+LTTool.h"

@implementation NSArray (LTTool)
#pragma mark - 数组转换
/**
 数组转换
 将原始数组里的每一个元素转换成一个新的元素
 @param mapBlock 转换的block
 @return 转换好的数组
 */
- (NSArray *)lt_map:(id(^)(id obj))mapBlock
{
    if (mapBlock == nil) {
        return self;
    }
    // 转换
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayM addObject:mapBlock(obj)];
    }];
    return [NSArray arrayWithArray:arrayM];
}
#pragma mark 数组过滤
/**
 数组过滤
 返回是否要包含，返回YES要保留，返回NO不保留
 @param filterBlock 过滤回调block
 @return 筛选过的新数组
 */
- (NSArray *)lt_filter:(BOOL(^)(id obj))filterBlock
{
    if (filterBlock == nil) {
        return self;
    }
    // 过滤
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (filterBlock(obj)) {
            [arrayM addObject:obj];
        }
    }];
    return [NSArray arrayWithArray:arrayM];
}
/**
 将以前是包含字典的数组变成可变字典的可变数组
 Array<Dict>->MutalbalrArray<NSMutableDict>
 @return 可变字典的可变数组
 */
- (NSMutableArray *)lt_map2DictMArray
{
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [arrayM addObject:[NSMutableDictionary dictionaryWithDictionary:obj]];
        }else{
            [arrayM addObject:obj];
        }
    }];
    return arrayM;
}
#pragma mark 找数组内最大的值
/**
 在数组的指定范围内找最大的一个对象
 如果obj2>obj1，则返回obj2
 @param range 在数组的范围内
 @param maxBlock 比较block
 @return 返回找到的值
 */
- (id)lt_findMaxInRange:(NSRange)range block:(BOOL(^)(id obj1,id obj2))maxBlock
{
    NSArray *array = [self lt_subArrayWithRange:range];
    if (array.count == 0) {
        return nil;
    }
    id resultObj = array.firstObject;
    if (maxBlock) {
        for(NSInteger i=1;i<array.count;i++){
            id obj2 = array[i];
            if (maxBlock(resultObj,obj2)) {
                resultObj = obj2;
            }
        }
    }
    return resultObj;
}

/**
 晒选字典数组，一某个key的integerValue进行排序
 
 @param range 要筛选的范围
 @param key 进行判断的key
 @return 筛选完成后的内容
 */
- (id)lt_findMaxInRange:(NSRange)range key:(NSString *)key
{
    return [self lt_findMaxInRange:range block:^BOOL(id obj1, id obj2) {
        return [[obj2 valueForKey:key] integerValue]>[[obj1 valueForKey:key] integerValue];
    }];
}
#pragma mark 创建有默认数据的数组
/**
 创建一个有填充内容的数组
 创建指定长度，并给每个位置都设置默认数据的数组
 @param count 数组长度
 @param fillBlock 填充默认数据的回调
 @return 创建好的数组
 */
+ (NSMutableArray *)lt_fillCount:(NSInteger)count fillBlock:(id(^)(NSInteger index))fillBlock
{
    NSMutableArray *arrayM = [NSMutableArray array];
    if (fillBlock != nil) {
        for (NSInteger i=0; i<count; i++) {
            id obj = fillBlock(i);
            if (obj) {
                [arrayM addObject:obj];
            }else{
                // 没有传数据则默认设置NSNull
                [arrayM addObject:[[NSNull alloc] init]];
            }
        }
    }
    return arrayM;
}
+ (NSMutableArray *)lt_fillCount:(NSInteger)count fillObj:obj
{
    return [self lt_fillCount:count fillBlock:^id(NSInteger index) {
        return obj;
    }];
}
#pragma mark - 创建一个数字数组
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to
{
    return [self lt_fillNumFrom:from to:to isTwo:NO prefix:nil suffix:nil];
}
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo
{
    return [self lt_fillNumFrom:from to:to isTwo:isTwo prefix:nil suffix:nil];
}
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo prefix:(NSString *)prefix suffix:(NSString *)suffix
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for(NSInteger i=from;i<=to;i++){
        NSString *txt = nil;
        if (isTwo) {
            txt = [NSString stringWithFormat:@"%02ld",i];
        }else{
            txt = [NSString stringWithFormat:@"%ld",i];
        }
        if (prefix != nil) {
            txt = [NSString stringWithFormat:@"%@%@",prefix,txt];
        }
        if (suffix != nil) {
            txt = [NSString stringWithFormat:@"%@%@",txt,suffix];
        }
        [arrayM addObject:txt];
    }
    return arrayM;
}
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo suffix:(NSString *)suffix prefixArray:(NSArray *)prefixArray
{
    NSMutableArray *arrayM = [self lt_fillNumFrom:from to:to isTwo:isTwo prefix:nil suffix:suffix];
    [arrayM lt_insertArray:prefixArray atIndex:0];
    return arrayM;
}
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo prefix:(NSString *)prefix suffix:(NSString *)suffix tailArray:(NSArray *)tailArray
{
    NSMutableArray *arrayM = [self lt_fillNumFrom:from to:to isTwo:isTwo prefix:prefix suffix:suffix];
    if (tailArray != nil && tailArray.count>0) {
        [arrayM addObjectsFromArray:tailArray];
    }
    return arrayM;
}
+ (NSMutableArray *)lt_fillNumFrom:(NSInteger)from to:(NSInteger)to isTwo:(BOOL)isTwo tailArray:(NSArray *)tailArray
{
    return [self lt_fillNumFrom:from to:to isTwo:isTwo prefix:nil suffix:nil tailArray:tailArray];
}
- (NSMutableArray *)lt_insertArray:(NSArray *)array atIndex:(NSInteger)index
{
    NSMutableArray *arrayM = nil;
    if ([self isKindOfClass:[NSMutableArray class]]) {
        arrayM = (NSMutableArray *)self;
    }else{
        arrayM = [NSMutableArray array];
    }
    if (array != nil && array.count>0) {
        [arrayM insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, array.count)]];
    }
    return arrayM;
}

+ (NSMutableArray *)lt_addArray:(NSArray *)array
{
    NSMutableArray *arrayM = nil;
    if ([self isKindOfClass:[NSMutableArray class]]) {
        arrayM = (NSMutableArray *)self;
    }else{
        arrayM = [NSMutableArray array];
    }
    if (array != nil && array.count>0) {
        [arrayM addObjectsFromArray:array];
    }
    return arrayM;
}
#pragma mark -
/**
 判断数组是否包含一格文本
 @param txt 需要比较包含的文本
 @param ignoreZero 是否忽略无意义的0
 @return 比较结果
 */
- (BOOL)lt_isContainsTxt:(NSString *)txt ignoreZero:(BOOL)ignoreZero;
{
    if (txt == nil) {
        // 空数据则不包含
        return NO;
    }
    // 兼容字符串和number类型
    NSArray *list = [self lt_map:^id(id obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%ld",[obj integerValue]];
        }else{
            return obj;
        }
    }];
    NSString *findTxt = txt;
    if ([findTxt isKindOfClass:[NSNumber class]]) {
        findTxt = [NSString stringWithFormat:@"%ld",[((NSNumber *)findTxt) integerValue]];
    }
    if (ignoreZero) {
        // 去掉无意义的0
        NSString *ignoreFindTxt = findTxt;
        while (ignoreFindTxt.length>1 && [ignoreFindTxt hasPrefix:@"0"]) {
            ignoreFindTxt = [ignoreFindTxt substringFromIndex:1];
        }
        // 对数组里的数字进行去掉无意义的0
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSString *originTxt in list) {
            NSString *noZeroTxt = originTxt;
            while (noZeroTxt.length>1 && [noZeroTxt hasPrefix:@"0"]) {
                noZeroTxt = [noZeroTxt substringFromIndex:1];
            }
            [arrayM addObject:noZeroTxt];
        }
        // 如果存在则包含
        return [arrayM indexOfObject:ignoreFindTxt] != NSNotFound;
    }else{
        // 如果存在则包含
        return [list indexOfObject:findTxt] != NSNotFound;
    }
    return NO;
}
/**
 数组包含某个字符串的个数
 
 @param txt 需要比较的个数
 @param ignoreZero 是否忽略无意义的0
 @return 包含的个数
 */
- (NSInteger)lt_containsCountWithTxt:(NSString *)txt ignoreZero:(BOOL)ignoreZero
{
    if (txt == nil) {
        // 空数据则不包含
        return 0;
    }
    NSArray *list = [self lt_map:^id(id obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%ld",[obj integerValue]];
        }else{
            return obj;
        }
    }];
    NSString *findTxt = txt;
    if ([findTxt isKindOfClass:[NSNumber class]]) {
        findTxt = [NSString stringWithFormat:@"%ld",[((NSNumber *)findTxt) integerValue]];
    }
    if (ignoreZero) {
        // 去掉无意义的0
        NSString *ignoreFindTxt = findTxt;
        while (ignoreFindTxt.length>1 && [ignoreFindTxt hasPrefix:@"0"]) {
            ignoreFindTxt = [ignoreFindTxt substringFromIndex:1];
        }
        // 对数组里的数字进行去掉无意义的0
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSString *originTxt in list) {
            NSString *noZeroTxt = originTxt;
            while (noZeroTxt.length>1 && [noZeroTxt hasPrefix:@"0"]) {
                noZeroTxt = [noZeroTxt substringFromIndex:1];
            }
            [arrayM addObject:noZeroTxt];
        }
        // 筛选掉不一样的内容
        return [arrayM lt_filter:^BOOL(NSString *filterTxt) {
            return [filterTxt isEqualToString:ignoreFindTxt];
        }].count;
    }else{
        return [list lt_filter:^BOOL(NSString *filterTxt) {
            return [filterTxt isEqualToString:findTxt];
        }].count;
    }
    return 0;
}
#pragma mark -
/**
 从一个数组里截取一个子数组，如果需要截取的长度大于数据的长度，以数据长度为准
 
 @param range 要截取的位置
 @return 截取后返回的数组
 */
- (NSArray *)lt_subArrayWithRange:(NSRange)range
{
    // 没有数据，则返回空数据
    if (self.count == 0) {
        return @[];
    }
    NSInteger from = range.location;
    // 如果开始位置大于数据长度，则返回空数组
    if (from>=self.count) {
        return @[];
    }
    NSInteger to = range.location+range.length-1;
    // 如果结束位置大于数据长度，则以数据的最后一个为结束位置
    if (to>=self.count) {
        to = self.count-1;
    }
    return [self subarrayWithRange:NSMakeRange(from, to-from+1)];
}
- (NSAttributedString *)lt_attrTxtWithColor:(UIColor *)color range:(NSRange)range seperator:(NSString *)seperator
{
    return [self lt_attrTxtWithColor:nil redRange:range redColor:color seperator:seperator];
}
- (NSAttributedString *)lt_attrTxtWithColor:(UIColor *)color redRange:(NSRange)redRange redColor:(UIColor *)redColor seperator:(NSString *)seperator
{
    NSArray *array = self;
    NSString *joinTxt = @"";
    NSInteger fromIndex = 0;
    NSInteger length = 0;
    for(NSInteger i=0;i<array.count;i++){
        // 计算真正的起始位置
        if (i==redRange.location) {
            fromIndex = joinTxt.length;
        }
        NSString *txt = array[i];
        if (i==0) {
            joinTxt = txt;
        }else{
            joinTxt = [NSString stringWithFormat:@"%@%@%@",joinTxt,seperator,txt];
        }
        // 计算真正的结束位置
        if (i == (redRange.location+redRange.length-1)) {
            length = joinTxt.length-fromIndex;
        }
    }
    
    NSMutableAttributedString *awardAttrTxt = [[NSMutableAttributedString alloc] initWithString:joinTxt];
    // 背景颜色
    if (color != nil) {
        [awardAttrTxt addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, joinTxt.length)];
    }
    // 红色
    [awardAttrTxt addAttribute:NSForegroundColorAttributeName value:redColor range:NSMakeRange(fromIndex, length)];
    return awardAttrTxt;
}
@end

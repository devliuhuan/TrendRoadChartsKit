//
//  NSDictionary+LTTool.h
//  TrendRoadChartsKitSample
//
//  Created by 独孤流 on 19/01/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LTTool)
- (NSString *)lt_parse2JsonTxt;
// 将dict合并到当前中
- (NSMutableDictionary *)lt_mergeWithDict:(NSDictionary *)dict;
@end
#pragma mark -
@interface NSMutableDictionary (LTTool)
- (void)lt_mergeDict:(NSDictionary *)dict;
@end

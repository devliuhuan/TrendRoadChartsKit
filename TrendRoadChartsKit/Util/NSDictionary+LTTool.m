//
//  NSDictionary+LTTool.m
//  TrendRoadChartsKitSample
//
//  Created by 独孤流 on 19/01/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "NSDictionary+LTTool.h"

@implementation NSDictionary (LTTool)
- (NSString *)lt_parse2JsonTxt
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = @"";
    if (error == nil && jsonData != nil) {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
- (NSMutableDictionary *)lt_mergeWithDict:(NSDictionary *)dict
{
    NSMutableDictionary *dictM = nil;
    if([self isKindOfClass:[NSMutableDictionary class]]){
        dictM = (NSMutableDictionary *)self;
    }else{
        dictM = [NSMutableDictionary dictionaryWithDictionary:self];
    }
    [dictM lt_mergeDict:dict];
    return dictM;
    
}
@end
#pragma mark -
@implementation NSMutableDictionary (LTTool)
// 将dict合并到当前中
- (void)lt_mergeDict:(NSDictionary *)dict
{
    if(dict == nil || ![dict isKindOfClass:[NSDictionary class]]){
        return;
    }
    for (NSString *key in dict) {
        self[key] = dict[key];
    }
}
@end

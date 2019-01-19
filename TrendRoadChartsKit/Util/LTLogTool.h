//
//  LTLogTool.h
//  TrendRoadChartsKit
//
//  Created by 独孤流 on 19/01/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//
#define kLTClassMethodName ([NSString stringWithFormat:@"%s",__FUNCTION__])
#import <Foundation/Foundation.h>

@interface LTLogTool : NSObject
+ (instancetype)shareInstance;
+ (void)reset;
+ (void)logWithTxt:(NSString *)txt;
+ (void)logWithTxts:(NSArray *)txts;
@end

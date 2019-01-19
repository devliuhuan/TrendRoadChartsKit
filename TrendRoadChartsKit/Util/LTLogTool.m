//
//  LTLogTool.m
//  TrendRoadChartsKit
//
//  Created by 独孤流 on 19/01/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "LTLogTool.h"
@interface LTLogTool()
@property (nonatomic,assign) NSInteger logCount;
@property (nonatomic,assign) CFAbsoluteTime start;
@property (nonatomic,assign) CFAbsoluteTime last;
@property (nonatomic,assign) CFAbsoluteTime end;
@end

@implementation LTLogTool
/**
 单例
 
 @return self
 */
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}
+ (void)reset
{
    LTLogTool.shareInstance.start = 0;
    LTLogTool.shareInstance.last = 0;
}
+ (void)logWithTxts:(NSArray *)txts
{
    NSString *paramsTxt = [txts componentsJoinedByString:@" "];
    [LTLogTool logWithTxt:paramsTxt];
}
+ (void)logWithTxt:(NSString *)txt
{
    if (LTLogTool.shareInstance.logCount == 0) {
        [LTLogTool reset];
    }
    LTLogTool.shareInstance.logCount++;
    LTLogTool.shareInstance.end = CFAbsoluteTimeGetCurrent();
    if (LTLogTool.shareInstance.start == 0) {
        LTLogTool.shareInstance.start = LTLogTool.shareInstance.end;
        LTLogTool.shareInstance.last = LTLogTool.shareInstance.end;
    }
    NSString *paramsTxt = txt;
    // 距离开始的时间 距离上一次记录日志的时间
    NSString *lotTxt = [NSString stringWithFormat:@"%@ %f %f",paramsTxt,LTLogTool.shareInstance.end - LTLogTool.shareInstance.start,LTLogTool.shareInstance.end - LTLogTool.shareInstance.last];
    printf("<<<%s\r\n", [lotTxt UTF8String]);
    LTLogTool.shareInstance.last = LTLogTool.shareInstance.end;
}
@end

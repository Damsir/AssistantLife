//
//  MJModelName.m
//  生活小助手
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MJModelName.h"
#import "MJExtension.h"

@implementation MJModelName



- (void)parseForAry:(NSDictionary *)dic{

    self.firstModelAry=[[NSMutableArray alloc]init];

    
    for (NSString *s in dic.allKeys) {
        
        NSDictionary *dic1=dic[s];
        
//        firstModel *model=[[firstModel alloc] mj_setKeyValues:dic1];
        
        [self.firstModelAry addObject:dic1];

    }
    
    
}

@end

@implementation firstModel






@end
//
//  InfoModel.m
//  生活小助手
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "InfoModel.h"
#import "MJExtension.h"



@implementation InfoModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"arry":@"1"};
}

- (void)parseForAry:(NSArray *)ary{
    
    self.datalist=[[NSMutableArray alloc]init];
    
    
    for (NSDictionary *dic in ary) {
        
        [self.datalist addObject:dic];
        
    }
}
@end

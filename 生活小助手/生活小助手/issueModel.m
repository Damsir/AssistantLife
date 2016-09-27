//
//  issueModel.m
//  生活小助手
//
//  Created by qianfeng on 15/12/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "issueModel.h"
#import "HtmlCore.h"

@implementation issueModel

+(NSMutableArray *)analyData:(NSArray *)arr
{
    NSMutableArray *data =[ NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        if([dic[@"type"] isEqualToString:@"select"])
        {
            NSArray *arra = [HtmlCore analyHtmlCore:dic[@"input"]];
            NSArray *array = @[arra,dic[@"name"],dic[@"fields"]];
            
            [data addObject:array];
        }
        if([dic[@"type"] isEqualToString:@"contingency"])
        {
            NSArray *array = @[@[@"field",@"field",@"field"],dic[@"name"],dic[@"fields"]];
            
            [data addObject:array];
        }
        
        if([dic[@"type"] isEqualToString:@"varchar"])
        {
            NSArray *array = @[@[@"field"],dic[@"name"],dic[@"fields"]];
            
            [data addObject:array];
        }
        if([dic[@"type"] isEqualToString:@"text"])
        {
            NSArray *array = @[@[@"field"],dic[@"name"],dic[@"fields"]];
            
            [data addObject:array];
        }
        if ([dic[@"type"] isEqualToString:@"checkbox"]) {
            
            NSArray *arra = [HtmlCore analySelect:dic[@"input"]];
            
            NSArray *array = @[arra,dic[@"name"],dic[@"fields"]];
            
            [data addObject:array];
            
        }
        
    }
    
    return data ;
}

@end

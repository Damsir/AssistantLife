//
//  PostDicData.m
//  生活小助手
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "PostDicData.h"

@implementation PostDicData
-(instancetype)initWithURL:(NSString *)url andDic:(NSDictionary *)dic
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        [_delegate recieveData:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
    return self ;
}

@end

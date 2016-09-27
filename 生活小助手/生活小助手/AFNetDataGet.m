//
//  AFNetDataGet.m
//  生活小助手
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "AFNetDataGet.h"

@implementation AFNetDataGet
-(instancetype)initWithGetDataGet:(NSString *)url1 withURL:(NSString *)url2 WithURL:(NSString *)url3
{
    self = [super init];
    
    if (self) {
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer] ;
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",url1,url2,url3] ;
    
    [manage GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(7,operation.responseString.length-8)];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription) ;
        
    }];
    
}
    return self ;
}
@end

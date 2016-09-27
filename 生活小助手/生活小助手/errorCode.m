//
//  errorCode.m
//  解析乱码
//
//  Created by qianfeng on 15/11/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "errorCode.h"

@implementation errorCode

-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        
    }
    
    return self ;
}

-(void)analysisByErrorCode:(NSString *)string
{
    
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    
    for (int i = 0 ; i < string.length; i++) {
        
        NSRange range = [mutStr rangeOfString:@">" options:NSLiteralSearch range:NSMakeRange(0, mutStr.length)];
        
        NSRange range1 = [mutStr rangeOfString:@"<" options:NSLiteralSearch range:NSMakeRange(0, mutStr.length)];
        
        if(range1.length == 0)
                    break;
        
        [mutStr deleteCharactersInRange:NSMakeRange(range1.location, range.location-range1.location+1)];
        
    }
    
    for (int i = 0; i < string.length; i++) {
        
        NSRange range2 = [mutStr rangeOfString:@"&" options:NSLiteralSearch range:NSMakeRange(0, mutStr.length)];
        
        if(range2.length == 0)
            break ;
        
        [mutStr deleteCharactersInRange:NSMakeRange(range2.location, 6)];
    }
    self.data = mutStr ;
    
    self.data = [self.data stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.data = [self.data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.data = [self.data stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
}













@end

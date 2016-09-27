//
//  UserInfo.m
//  生活小助手
//
//  Created by qianfeng on 15/12/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UserInfo.h"
static UserInfo *user ;
@implementation UserInfo
+(instancetype)sharedUserInformation
{
    //    @synchronized(self)
    
    static dispatch_once_t onceToken ;
    
    dispatch_once(&onceToken, ^{
        if(!user)
        {
            user = [[UserInfo alloc]init];
        }
        
    });
    
    return user ;
}
-(instancetype)init
{
    if (self = [super init]) {
        
        _userId = [NSString string] ;
        
        _m_auth = [NSString string] ;
        
    }
    return self ;
}

@end

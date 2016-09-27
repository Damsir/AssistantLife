//
//  UserInfo.h
//  生活小助手
//
//  Created by qianfeng on 15/12/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic,copy)  NSString *userId;

@property (nonatomic,copy)  NSString *m_auth;

+(id)sharedUserInformation;
@end

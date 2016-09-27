//
//  errorCode.h
//  解析乱码
//
//  Created by qianfeng on 15/11/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface errorCode : NSObject
@property (nonatomic,copy)  NSString *data;
-(void)analysisByErrorCode:(NSString *)string ;
@end

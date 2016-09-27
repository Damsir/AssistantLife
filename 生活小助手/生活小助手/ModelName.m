//
//  ModelName.m
//  生活小助手
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ModelName.h"
#import "MJExtension.h"


@implementation ModelName

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"classtype":@"classtype",@"classtype2":@"classtype2",@"ads":@"ads"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"classtype":@"Classtype"};
}
@end

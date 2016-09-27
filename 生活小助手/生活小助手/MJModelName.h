//
//  MJModelName.h
//  生活小助手
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@class firstModel;

@interface MJModelName : NSObject

@property (nonatomic,strong) NSDictionary *classtype;

@property (nonatomic,strong) NSDictionary *classtype2;

@property (nonatomic,strong) NSDictionary *ads;

@property (nonatomic,strong) NSMutableArray *firstModelAry;

- (void)parseForAry:(NSDictionary *)dic;

@end

@interface firstModel : NSObject

@property (nonatomic,strong) NSString *tid;

@property (nonatomic,copy)  NSString *classname;

@property (nonatomic,copy)  NSString *appico;

@property (nonatomic,copy)  NSString *app_index;

@property (nonatomic,copy)  NSDictionary *c;


@end


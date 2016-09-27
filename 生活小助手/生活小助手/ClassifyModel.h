//
//  ClassifyModel.h
//  生活小助手
//
//  Created by qianfeng on 15/12/2.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"



@protocol classifyinfoModel <NSObject>

@end

@interface classifyClassname : JSONModel

@property (nonatomic,strong) NSString *classname;

@property (nonatomic,strong) NSString *tid;

@property (nonatomic,strong) NSString *appico;

@property (nonatomic,strong) NSArray < classifyinfoModel > *c;

@end

@interface classifyinfoModel : JSONModel

@property (nonatomic,strong) NSString *tid;

@property (nonatomic,strong) NSString *pid;

@property (nonatomic,strong) NSString *classname;
@end











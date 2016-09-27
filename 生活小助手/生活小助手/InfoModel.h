//
//  InfoModel.h
//  生活小助手
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

@property (nonatomic,strong) NSDictionary *arry ;

@property (nonatomic,strong) NSMutableArray *datalist;

- (void)parseForAry:(NSArray *)ary ;

@end

//
//  PostData.h
//  生活小助手
//
//  Created by qianfeng on 15/12/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PostDataDelegate <NSObject>
-(void)recieveData:(NSArray *)dicData;
@end






@interface PostData : NSObject
-(instancetype)initWithURL:(NSString *)url andDic:(NSDictionary *)dic ;
@property (nonatomic,retain)  id <PostDataDelegate> delegate;
@end

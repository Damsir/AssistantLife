//
//  PostDicData.h
//  生活小助手
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PostDicDataDelegate <NSObject>
-(void)recieveData:(NSDictionary *)dicData;
@end


@interface PostDicData : NSObject
@property (nonatomic,retain)  id < PostDicDataDelegate > delegate;

-(instancetype)initWithURL:(NSString *)url andDic:(NSDictionary *)dic;

@end

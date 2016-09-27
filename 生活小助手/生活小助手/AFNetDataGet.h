//
//  AFNetDataGet.h
//  生活小助手
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AFNetDataGetDelegate <NSObject>
-(void)recieveData:(NSDictionary *)dic ;
@end


@interface AFNetDataGet : NSObject
@property (nonatomic,retain)  id < AFNetDataGetDelegate > delegate ;
-(instancetype)initWithGetDataGet:(NSString *)url1 withURL:(NSString *)url2 WithURL:(NSString *)url3;
@end

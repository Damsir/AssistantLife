//
//  NetData.h
//  爱限免
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol NetDataDelegate <NSObject>
-(void)recieveData:(NSDictionary *)dic andtag:(NSInteger)tag;
@end





@interface NetData : NSObject
@property (nonatomic,retain)  id < NetDataDelegate > delegate ;
-(instancetype)initWithurlStr:(NSString *)string andtag:(NSInteger)num ;
@end

//
//  HtmlCore.h
//  解析Html
//
//  Created by qianfeng on 15/12/5.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlCore : NSObject
+(NSArray *)analyHtmlCore:(NSString *)string ;
+(NSArray *)analySelect:(NSString *)string ;

+(NSString *)grtnsstring:(NSString*)str ;

@end

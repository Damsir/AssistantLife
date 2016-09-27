//
//  HtmlCore.m
//  解析Html
//
//  Created by qianfeng on 15/12/5.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HtmlCore.h"
//<select name="zpqzxskfcgtbxs_lb" id="zpqzxskfcgtbxs_lb"><option value="销售代表" >销售代表</option><option value="销售助理" >销售助理</option><option value="销售经理/主管" >销售经理/主管</option><option value="销售总监" >销售总监</option><option value="营销策划" >营销策划</option><option value="电话销售" >电话销售</option><option value="销售支持" >销售支持</option><option value="汽车销售" >汽车销售</option><option value="医药代表" >医药代表</option><option value="医疗器械销售" >医疗器械销售</option><option value="网络销售" >网络销售</option><option value="区域销售" >区域销售</option><option value="渠道专员" >渠道专员</option><option value="渠道经理/总监" >渠道经理/总监</option><option value="客户经理/主管" >客户经理/主管</option><option value="大客户经理" >大客户经理</option><option value="团购业务员/经理" >团购业务员/经理</option><option value="会籍顾问" >会籍顾问</option></select>
@implementation HtmlCore
+(NSArray *)analyHtmlCore:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0 ; i < string.length; i++) {
        
        NSRange range1 = [str rangeOfString:@"<option"];
        
        NSRange range2 = [str rangeOfString:@"</option>"];
        
        if(range2.length == 0)
            break ;
        
        NSString *str1 = [str substringWithRange:NSMakeRange(range1.location, range2.location - range1.location)];
        
        [str deleteCharactersInRange:NSMakeRange(range1.location, range2.location- range1.location+2)];
        
        [arr addObject:str1];
        
       
    }
    
    NSMutableArray *data = [NSMutableArray array];
    
    for (NSString *str1 in arr) {
        
        NSRange range = [str1 rangeOfString:@">"];
        
        NSString *stra = [str1 substringFromIndex:range.location+1];
        
        [data addObject:stra];
    }
    
    
    
    return data;
}

+(NSArray *)analySelect:(NSString *)string
{
    NSMutableArray *data = [NSMutableArray array];
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    [str deleteCharactersInRange:NSMakeRange(0, 2)];
    
    for (int i= 0; i < string.length ; i++) {
        
        NSRange range1 = [str rangeOfString:@">"];
        
        NSRange range2 = [str rangeOfString:@"<in"];
        
        if(range2.length == 0)
        {
            NSString *stri = [str substringFromIndex:range1.location+1];
            
            [data addObject:stri];
            
            break ;
        }
        else
        {
            NSString *stri = [str substringWithRange:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
            
            [str deleteCharactersInRange:NSMakeRange(range1.location, range2.location-range1.location+1)];
            
            [data addObject:stri];
        }
        
    }
    
    return data;
    
}



+(NSString *)grtnsstring:(NSString*)str
{
//    NSMutableString *str1 = [NSMutableString string];
    NSRange range1 = [str rangeOfString:@"('"];
    NSRange range2 = [str rangeOfString:@"')"];
    
    NSString *str1 = [str substringWithRange:NSMakeRange(range1.location+2, range2.location-range1.location-2)];
    
    return str1 ;
}









@end

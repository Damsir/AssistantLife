//
//  issueTableViewCell.m
//  生活小助手
//
//  Created by qianfeng on 15/12/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "issueTableViewCell.h"

@implementation issueTableViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
    }
    return self ;
}

-(UIView *)setOfView:(NSString *)str
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, 22)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, WIDEMAX, 22)];
    
    label.text = str ;
    
    label.font = [UIFont systemFontOfSize:20];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:@"ic_guide_jn_net_checked"] forState:UIControlStateSelected];
    
    [btn setImage:[UIImage imageNamed:@"ic_deal_order_checkbox_normal"] forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(20,2.5, 18, 18);
    
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    [view addSubview:label];
    
     [view addSubview:btn];
    return view ;
    
}

-(void)BtnClick:(UIButton *)sender
{
    sender.selected = YES ;
}












@end

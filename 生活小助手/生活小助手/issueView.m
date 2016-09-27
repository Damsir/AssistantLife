//
//  issueView.m
//  生活小助手
//
//  Created by qianfeng on 15/12/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "issueView.h"

@implementation issueView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
//        self.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 100, 28)];
        
        _label.font = [UIFont systemFontOfSize:20];
        
        _label.textColor =[UIColor colorWithRed:0.000 green:0.400 blue:0.800 alpha:1.000];
        
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 2.5, 28, 28)];
        
        self.imageview.image = [UIImage imageNamed:@"ic_down_arrow_green"];
        
        [self addSubview:self.imageview];
        
        [self addSubview:_label];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.imageview.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }];
        
        self.isOpen = NO ;

    }
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if(self.isOpen == YES)
    {
        [UIView animateWithDuration:0.4 animations:^{
            self.imageview.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }];
        self.isOpen = NO ;
    }
    else
    {
        [UIView animateWithDuration:0.4 animations:^{
            self.imageview.transform = CGAffineTransformMakeRotation(0);
        }];
        
        self.isOpen = YES ;
    }
    self.openGroup() ;
}















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

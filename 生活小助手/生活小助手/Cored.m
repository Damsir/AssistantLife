//
//  ViewController.m
//  动画-1
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Cored.h"

@interface Cored ()
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation Cored

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(animationView) userInfo:nil repeats:YES];

}
-(UIImageView *)creat:(NSString *)string
{
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 60, 60)];
    
    _image.image = [UIImage imageNamed:string];
    
    [self animationView];
    
    return _image ;
}
-(void)animationView
{
    static BOOL is = YES;
    static int i = 1 ;
    if(is){
        [UIView animateWithDuration:1 animations:^{
            _image.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        is = NO ;
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            _image.transform = CGAffineTransformMakeRotation(0);
        }];
        is = YES ;
    }
//    if(i%20>10)
//    {
//        [UIView animateWithDuration:1 animations:^{
//            _label.transform = CGAffineTransformMakeScale(2, 2);
//            _label.transform = CGAffineTransformMakeTranslation(10, 10);
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:1 animations:^{
//            _label.transform = CGAffineTransformMakeScale(0.2, 0.2);
//            _label.transform = CGAffineTransformMakeTranslation(15, 15);
//
//        }];
//    }
    i ++;
    
    

    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

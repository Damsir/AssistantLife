//
//  AlterViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "AlterViewController.h"

@interface AlterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *oldpass;
@property (strong, nonatomic) IBOutlet UITextField *newpass;
@property (strong, nonatomic) IBOutlet UITextField *pass1;

@end

@implementation AlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnClick:(id)sender {
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"c":@"member",@"a":@"myinfo",@"appapi":@"1",@"go":@"1",@"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"user"],@"pass":self.oldpass.text,@"pass1":self.newpass.text,@"pass2":self.pass1.text,@"email":@"",@"phone":@""};
    
    [manage POST:@"http://kuaidianwo.com" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
        
        NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSString *mess ;
        
        if(dics)
            mess = @"密码错误";
        else if(![dic[@"pass1"] isEqualToString:dic[@"pass2"]])
            mess = @"两次密码输入不一样";
        else
            mess = @"修改成功";
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:mess delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        self.oldpass.text = @"";
        self.pass1.text = @"";
        self.newpass.text = @"";
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

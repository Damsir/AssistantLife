//
//  MyViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/21.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MyViewController.h"
#import "RegiViewController.h"
#import "OneSelfViewController.h"
#import "UserInfo.h"

@interface MyViewController () < UITextFieldDelegate >

@property (nonatomic,strong) UITextField *userName;

@property (nonatomic,strong) UITextField *passWord;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, HEIGHRMAX)];
    
    imageview.image = [UIImage imageNamed:@"Launching"];
    
    [self.view addSubview:imageview];
    
    self.tabBarController.tabBar.hidden = YES ;
    
    self.navigationController.navigationBar.hidden = YES ;
    
    
    [self configUI];
    
    [self configBtn];
}

-(void)configUI
{
    self.userName = [[UITextField alloc]init];
    
    self.userName.bounds = CGRectMake(0, 0, 170, 28);
    self.userName.center = CGPointMake((WIDEMAX+70)/2.0, 200);
    
    self.userName.placeholder = @"请输入用户名";
    self.userName.borderStyle = UITextBorderStyleRoundedRect ;
    self.userName.font = [UIFont systemFontOfSize:15];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x-70, self.userName.frame.origin.y, 60, 28)];
    
    name.textColor = [UIColor whiteColor];
    name.textAlignment = NSTextAlignmentCenter ;
    name.text = @"用户名:";
    name.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:name];
    
    self.userName.delegate = self ;
    
    self.passWord = [[UITextField alloc]init];
    
    self.passWord.bounds = self.userName.bounds ;
    self.passWord.center = CGPointMake((WIDEMAX+70)/2.0, CGRectGetMaxY(self.userName.frame)+30);
    
    self.passWord.placeholder = @"请输入密码";
    self.passWord.borderStyle = UITextBorderStyleRoundedRect ;
    self.passWord.font = [UIFont systemFontOfSize:15];
    
    UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(self.passWord.frame.origin.x-70, self.passWord.frame.origin.y, 60, 28)];
    
    word.textColor = [UIColor whiteColor];
    word.textAlignment = NSTextAlignmentCenter ;
    word.text = @"密   码:";
    word.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:word];
    
    self.passWord.secureTextEntry = YES ;
    
    self.passWord.delegate = self ;
    
    [self.view addSubview:self.passWord];
    
    [self.view addSubview:self.userName];
    
}

-(void)configBtn
{
    
    NSArray *str = @[@"登   录",@"注   册"];
    
    for (int i = 0 ; i < 2 ; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.bounds = CGRectMake(0, 0, 60, 30);
        
        btn.center = CGPointMake(WIDEMAX/2.0, CGRectGetMaxY(self.passWord.frame)+(1+i)*50);
        
        [btn setTitle:str[i] forState:UIControlStateNormal];
        
        btn.backgroundColor = [UIColor greenColor];
        
        [self.view addSubview:btn];
        
        btn.tag = 1000 + i ;
        
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)BtnClick:(UIButton *)sender
{
    NSInteger num = sender.tag - 1000 ;
    
    switch (num) {
        case 0:
            [self launchBySender];
            break;
        case 1:
            [self registBySender];
            break ;
        default:
            break;
    }
    
}

-(void)launchBySender
{
    
    NSDictionary *dic = @{@"c":@"member",@"a":@"login",@"user":self.userName.text,@"pass":self.passWord.text};
    
    [self loadData:regis_API andDic:dic];
    
}
-(void)registBySender
{
    RegiViewController *gvc = [[RegiViewController alloc]init];
    
    gvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical ;
    
    [self presentViewController:gvc animated:YES completion:nil];
    
}

-(void)loadData:(NSString *)url andDic:(NSDictionary *)dic
{
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
        
         NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        if([dics[@"info"] isEqualToString:@"ok"])
        {
            OneSelfViewController *osvc = [[OneSelfViewController alloc]init];
            
            UserInfo *info = [UserInfo sharedUserInformation];
            
            info.userId = self.userName.text ;
            
            info.m_auth = self.passWord.text ;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setBool:YES forKey:@"Mycontro"];
            
            [defaults setObject:self.userName.text forKey:@"user"];
            
            [defaults setObject:self.passWord.text forKey:@"pass"];
            
    
            [self.navigationController pushViewController:osvc animated:YES];
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dics[@"info"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField endEditing:YES];
    
    return YES ;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

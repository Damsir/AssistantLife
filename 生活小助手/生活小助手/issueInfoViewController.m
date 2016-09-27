//
//  issueInfoViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.




//   a=addinfos_fields&tid=222&user=zzzzz&pass=zzzzzz

#import "issueInfoViewController.h"
#import "issueModel.h"
#import "issueTableViewCell.h"
#import "HtmlCore.h"


@interface issueInfoViewController () <UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate ,UITextFieldDelegate >

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSArray *arrdata;

@property (nonatomic,strong) NSMutableDictionary *arrHead;

@property (nonatomic,strong) NSMutableArray *selected ;

@property (nonatomic,strong) NSMutableArray *dic;

@property (nonatomic,strong) NSMutableArray *fieldss;

@property (nonatomic,strong) NSMutableArray *labels;

@property (nonatomic,strong) NSIndexPath *inPath;

@property (nonatomic,strong) NSMutableArray *sarr;

@property (nonatomic,strong) UIView *configView;

@property (nonatomic,strong) NSMutableArray *labelview ;


@property (nonatomic,strong) NSMutableArray *datalist ;

@end

@implementation issueInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.arrHead = [NSMutableDictionary dictionary];
    
    self.dic = [NSMutableArray array];
    
    self.labels = [NSMutableArray array];
    
    self.sarr = [NSMutableArray array];
    
    self.labelview = [NSMutableArray array];
    
    self.datalist = [NSMutableArray array];
    
    [self configUI];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn.bounds = CGRectMake(0, 0, 40, 40);
    
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    
    [btn setTitle:@"取消" forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
   
}
-(void)BtnClick:(UIButton *)sender
{
    static BOOL iso = YES ;
    
  
    
    NSMutableArray *ata = [NSMutableArray array];
    
    for (int i = 0; i< self.arrdata.count;i++ )
    {
        UILabel *label = self.labels[i];
        
        if(label.text)
        {
            [ata addObject:label.text];
        }
        else if(self.arrdata.count-1 == i)
        {
            NSMutableArray *att = [NSMutableArray array];
            
            for (UITableViewCell *cell in self.sarr) {
                
                [att addObject:cell.textLabel.text];
                
            }
            if(att.count == 0)
                [att addObject:@" "];
            [ata addObject:att];
        }
        else if ([self.arrdata[i][2] isEqualToString:@"quyu"])
        {
            [ata addObject:@""];
        }
        else
        {
            [ata addObject:@""];
        }
        
    }
    
    if(iso)
    {
        sender.selected = YES ;
        iso = NO;
        
        [self animationView:ata];
        
    }
    else
    {
        sender.selected = NO ;
        iso = YES ;
        
        [self stopanimatioView:ata];
    }
    
    
    
}

-(void)stopanimatioView:(NSArray *)data
{
    
    [UIView animateWithDuration:1 animations:^{
        self.configView.bounds = CGRectMake(0, 0, 0, 0);
        self.configView.center = CGPointMake(WIDEMAX/2.0, HEIGHRMAX/2.0);
        self.table.alpha = 1 ;
        
        
        for (int i= 0 ; i < self.arrdata.count; i++) {
            
            UILabel *label = self.labelview[i];
            
            label.bounds = CGRectMake(0, 0,self.configView.frame.size.width * 0.8,self.configView.frame.size.height * 0.04);
            
            label.center = CGPointMake(self.configView.frame.size.width/2.0, self.configView.frame.size.height/2.0);
            
            if (self.arrdata.count == i+1) {
                
                NSMutableString *string = [NSMutableString string];
                
                for (NSString * obj in data[i]) {
                    
                    [string appendString:[NSString stringWithFormat:@"%@ ",obj]];
                }
                
                label.text = string ;
                
            }
            else
                label.text =[NSString stringWithFormat:@"%@:%@",self.arrdata[i][1],data[i]];
            
            label.textColor = [UIColor blackColor];
            
           label.font = [UIFont systemFontOfSize:self.configView.frame.size.height * 0.04];
            
            [self.configView addSubview:label];
            
            
        }
        
        self.configView.alpha = 0 ;

    }];
    
    
    
}

-(void)animationView:(NSArray *)data
{
    
    self.datalist = data ;
    
    [UIView animateWithDuration:1 animations:^{
        self.configView.bounds = CGRectMake(0, 0, WIDEMAX * 0.8, HEIGHRMAX * 0.8);
        self.configView.center = CGPointMake(WIDEMAX/2.0, HEIGHRMAX/2.0);
        
        self.table.alpha = 0.2 ;

    for (int i= 0 ; i < self.arrdata.count; i++) {
        
        UILabel *label = self.labelview[i];
        
        label.bounds = CGRectMake(0, 0, WIDEMAX * 0.75, HEIGHRMAX *0.8 * 0.04);
        
        label.center = CGPointMake(WIDEMAX * 0.4, 30+ i * (HEIGHRMAX * 0.8 * 0.04 +10));
        
        if (self.arrdata.count == i+1) {
            
            NSMutableString *string = [NSMutableString stringWithFormat:@"%@:",self.arrdata[i][1]];
            
            for (NSString * obj in data[i]) {
                
                [string appendString:[NSString stringWithFormat:@"%@ ",obj]];
            }
            
            label.text = string ;
            
        }
        else
            label.text =[NSString stringWithFormat:@"%@:%@",self.arrdata[i][1],data[i]];
        
        NSRange range = [label.text rangeOfString:@":"];
        
        NSString *str = [label.text substringWithRange:NSMakeRange(0, range.location+1)];
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:label.text];
        
        [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[label.text rangeOfString:str]];
        
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:[label.text rangeOfString:str]];
        
        label.attributedText = str1 ;
    
            self.configView.alpha = 1 ;
        
        if(self.arrdata.count - 1 == i)
            label.bounds = CGRectMake(0, 0, WIDEMAX * 0.75, HEIGHRMAX * 1.6 * 0.04);
        
        label.numberOfLines = 0 ;
        
        label.font = [UIFont systemFontOfSize:20];
        
        [self.configView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        
        btn.bounds = CGRectMake(0, 0, 60, 20);
        
        btn.center = CGPointMake(self.configView.frame.size.width/2.0, self.configView.frame.size.height - 40);
        
        [self.configView addSubview:btn];
        
        [btn addTarget:self action:@selector(BtnClickque:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    }];
}

-(void)BtnClickque:(UIButton *)sender
{
    
    NSString *user=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    
    NSString *pass = [[NSUserDefaults standardUserDefaults] objectForKey:@"pass"];
    
    
    NSDictionary *dic=@{@"c":@"member",@"a":@"addinfosgo",@"appapi":@"1",@"go":@"1",@"tid":@"222",@"user":user,@"pass":pass,@"title":@""};
    
    NSMutableDictionary *dicss = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    for (int i = 0; i < self.arrdata.count; i++) {
        
        if(i == self.arrdata.count-1)
        {
            
            for (NSString *str1 in self.datalist[i]) {
                
                [str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                 [dicss setObject:str1 forKey:self.arrdata[i][2]];
                
                
            }
        }
        else
            [dicss setObject:self.datalist[i] forKey:self.arrdata[i][2]];
        
    }
    
    [self resquestData:shoucang_API andDic:dicss];
    
}

-(void)resquestData:(NSString *)url andDic:(NSDictionary *)dics
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:url parameters:dics success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
        
        NSString *str2 = [HtmlCore grtnsstring:str];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str2 delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        
        [alert show];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];

}


-(void)configViews
{
    self.configView = [[UIView alloc]init];
    
    self.configView.bounds = CGRectMake(0, 0, 0, 0);
    
    self.configView.center = CGPointMake(WIDEMAX/2.0, HEIGHRMAX/2.0);
    
    self.configView.backgroundColor = [UIColor colorWithRed:0.000 green:0.600 blue:1.000 alpha:0.500];
    
    [self.view addSubview:self.configView];
    
    for (int i= 0 ; i < self.arrdata.count; i++) {
        
        UILabel *label = [[UILabel alloc]init];
        
        label.bounds = CGRectMake(0, 0,10,10);
        
        label.center = CGPointMake(self.configView.frame.size.width/2.0, self.configView.frame.size.height/2.0);
        
        label.textColor = [UIColor blackColor];
        
         label.numberOfLines = 0 ;
        
//        label.adjustsFontSizeToFitWidth = YES ;
        
        label.minimumScaleFactor = 12 ;
        
        [self.configView addSubview:label];
        
        [self.labelview addObject:label];
        
    }
}


-(void)configUI
{
    NSDictionary *dic = @{@"a":@"addinfos_fields", @"tid":self.tid , @"user":[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] ,@"pass":[[NSUserDefaults standardUserDefaults] objectForKey:@"pass"]};
    
    [self creatWithURL:regis_API andDic:dic];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, HEIGHRMAX-49) style:UITableViewStylePlain];
    
    self.table.delegate = self ;
    
    self.table.dataSource = self ;
    
    self.table.backgroundColor = [UIColor whiteColor];
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.table.bounces = YES ;
    
    self.selected = [NSMutableArray array];
    
    [self.view addSubview:self.table];
    
    self.fieldss = [NSMutableArray array];
    
}

-(void)creatWithURL:(NSString *)url andDic:(NSDictionary *)dic
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
      self.arrdata = [issueModel analyData:dic[@"fields"]];
       
        [self configViews];
        
        [self.table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrdata.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    issueView *isview = [self.arrHead objectForKey:@(section)];
    if(!isview.isOpen)
    {
        return 0 ;
    }
    else
        return [self.arrdata[section][0] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40 ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    issueView *isview = [self.arrHead objectForKey:@(section)];
    if(!isview)
    {
        isview = [[issueView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, 30)];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDEMAX-200, 0, 200, 30)];
        
        label.adjustsFontSizeToFitWidth = YES ;
        
        label.textAlignment = NSTextAlignmentCenter ;
        
        label.textColor = [UIColor blackColor];
//        label.backgroundColor=[UIColor redColor];
        
        [self.labels addObject:label];
        
        [isview addSubview:label];
        
        isview.label.text = self.arrdata[section][1];
        
        
        __weak typeof(*&self)weakSelf=self;
        
        isview.openGroup = ^{
            
                        [weakSelf.table reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
            
                    };
        [self.arrHead setObject:isview forKey:@(section)];
        
    }
    return isview;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [NSString stringWithFormat:@"%ld",indexPath.section] ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];                                                                                                                             
        
        [self coustomAndCell:cell andIndexPath:indexPath];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *str = self.arrdata[indexPath.section][0][0];
    if([str isEqualToString:@"field"])
    {
        return 40;
    }
    else
        return 30;
}

-(void)coustomAndCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.arrdata[indexPath.section][0][0];
    
    NSArray *arr = @[@"省:",@"市:",@"区:"];
    
    if ([self.arrdata[indexPath.section][2] isEqualToString:@"quyu"]) {
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(30, 1, WIDEMAX-31, 38)];
        
        field.borderStyle = UITextBorderStyleLine ;
        
        field.delegate = self ;
        
        [cell.contentView addSubview:field];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, 30, 35)];
        
        label.text = arr[indexPath.row];
        
        label.textColor = [UIColor lightGrayColor];
        
        [cell.contentView addSubview:label];
        
        field.tag = 1000 * indexPath.section +indexPath.row ;
        
        [self.fieldss addObject:indexPath];
        
    }
    
  else if([str isEqualToString:@"field"])
    {
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(1, 1, WIDEMAX-2, 38)];
        
        field.borderStyle = UITextBorderStyleLine ;
        
        field.delegate = self ;
        
        [cell.contentView addSubview:field];
        
        field.tag = 1000 *indexPath.section + indexPath.row ;
        
        [self.fieldss addObject:indexPath];
        
    }
   else if(indexPath.section == self.arrdata.count-1)
    {
        
        cell.textLabel.text = self.arrdata[indexPath.section][0][indexPath.row];
        
        cell.imageView.image = [UIImage resizableImage:@"ic_deal_order_checkbox_normal" andSize:CGSizeMake(26, 26)];
        
        if ([self.selected containsObject:indexPath]) {
                cell.imageView.image = [UIImage resizableImage:@"ic_guide_jn_net_checked" andSize:CGSizeMake(26, 26)];
        }
        
    }
   else
   {
       cell.textLabel.text = self.arrdata[indexPath.section][0][indexPath.row];
   }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *str = self.arrdata[indexPath.section][0][0];
  
    if(indexPath.section == self.arrdata.count - 1)
    {
        if([self.selected containsObject:indexPath])
        {
            cell.imageView.image = [UIImage resizableImage:@"ic_deal_order_checkbox_normal" andSize:CGSizeMake(26, 26)];
            
            [self.selected removeObject:indexPath];
            
            [self.sarr removeObject:cell];
        }
        else
        {
            cell.imageView.image = [UIImage resizableImage:@"ic_guide_jn_net_checked" andSize:CGSizeMake(26, 26)];
            
            [self.selected addObject:indexPath];
            
            [self.sarr addObject:cell];
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if([str isEqualToString:@"field"])
    {
        
    }
    else
    {
        if(![self.dic containsObject:@(indexPath.section)])
        {
            UITableViewCell *cell = [self.table cellForRowAtIndexPath:indexPath];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDEMAX-40, 2.5, 24, 24)];
            
            imageView.image = [UIImage resizableImage:@"ic_guide_jn_net_checked" andSize:CGSizeMake(26, 26)];
            
            [cell.contentView addSubview:imageView];
            
            [self.dic addObject:@(indexPath.section)];
        }
        else
        {
            if(_inPath.section == indexPath.section)
            {
                UITableViewCell *cell = [self.table cellForRowAtIndexPath:_inPath];
                
                NSArray *arr = [cell.contentView subviews];
                
                for (id obj in arr) {
                    
                    if([[obj class] isSubclassOfClass:[UIImageView class]])
                    {
                        [obj removeFromSuperview];
                    }
                }
            }
           
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDEMAX-40, 2.5, 24, 24)];
            
            imageView.image = [UIImage resizableImage:@"ic_guide_jn_net_checked" andSize:CGSizeMake(24, 24)];
            
            [cell.contentView addSubview:imageView];
            
            [self.dic addObject:@(indexPath.section)];
            
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UILabel *label = self.labels[indexPath.section] ;
        
        label.text = cell.textLabel.text ;

    }
    
    
    _inPath = indexPath ;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES ;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSLog(@"%@,%@",textField.text,string);
    
    NSInteger num = textField.tag/1000 ;
   
    if ([self.arrdata[num][2] isEqualToString:@"quyu"])
    {
        if(textField.tag%1000 == 0 )
        {
            
        }
        
    }
    else
    {
        UILabel *label = self.labels[num] ;

        label.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if([string isEqualToString:@""])
        {
            label.text = [label.text substringWithRange:NSMakeRange(0, label.text.length-1)];
        }
    }
    
    
    return YES;
    
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

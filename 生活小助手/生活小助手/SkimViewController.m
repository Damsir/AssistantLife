//
//  SkimViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "SkimViewController.h"

@interface SkimViewController () < UITableViewDataSource,UITableViewDelegate >

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *datalist ;

@end

@implementation SkimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self configUI];
}

-(void)configUI
{
    
    self.datalist = [NSMutableArray array];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, HEIGHRMAX -44) style:UITableViewStylePlain];
    
    self.table.delegate = self ;
    
    self.table.dataSource = self ;
    
    [self.view addSubview:self.table];
    
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"skim"];
    
    for (id obj in arr) {
        
        [self loadData:obj];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.bounds = CGRectMake(0, 0, 100, 24);
    
    [btn setTitle:@"清除浏览" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor colorWithRed:0.000 green:0.800 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    
    [btn addTarget:self  action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
-(void)BtnClick:(UIButton *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:@"skim"];
    
    [self configUI];
}
-(void)loadData:(NSString *)strid
{
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager] ;
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer] ;
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    
    NSString *str =[NSString stringWithFormat:Information_API,strid];
    
    [manage GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length - 2)];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        [self.datalist  addObject:dic];
        
        [self.table reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    NSDictionary *dic = self.datalist[indexPath.row][@"info"];
    
    cell.textLabel.text = dic[@"title"];
    
    cell.detailTextLabel.text = dic[@"addtime"];
    
    return cell ;
    
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

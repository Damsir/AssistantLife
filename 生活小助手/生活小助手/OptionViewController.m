//
//  OptionViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "OptionViewController.h"
#import "MJModelName.h"
#import "MainViewController.h"
#import "MJExtension.h"
#import "DrawerViewController.h"
#import "InfoBaseViewController.h"




@interface OptionViewController () < UITableViewDataSource , UITableViewDelegate >
@property (nonatomic,assign) NSInteger index ;
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) NSMutableArray *datalist;
@property (nonatomic,strong) MainViewController *main ;



@end

@implementation OptionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor clearColor];
        
    [self configUI];
    
}

-(void)changDictionAry:(NSDictionary *)dic
{
    _datalist = [NSMutableArray array];

    _dic = dic;
    
    NSArray *string = [[_dic objectForKey:@"c"] allKeys];
    
    NSDictionary *dics = [_dic objectForKey:@"c"];
    
    for (NSString *str in string) {
        
        NSArray *dic1 = dics[str];
        
        [_datalist addObject:dic1];
        
    }
    
    [self.table reloadData];
    
}

-(void)configUI
{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,20, 200, HEIGHRMAX)];
        
    self.table .delegate = self ;
    
    self.table.backgroundColor = [UIColor whiteColor];
    
    self.table .dataSource = self ;
    
    self.table.showsVerticalScrollIndicator = NO ;
    
    self.table.alpha = 1 ;
    
    self.table.backgroundColor = [UIColor clearColor];
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    [self.view addSubview:self.table];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datalist.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    
    NSString *str = [_datalist[indexPath.row] objectForKey:@"classname"];
    
    cell.textLabel.text =str ;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    InfoBaseViewController *info = [[InfoBaseViewController alloc]init];
   
    info.url = [NSString stringWithFormat:Info_API,[_dic objectForKey:@"tid"],[_datalist[indexPath.row] objectForKey:@"tid"]];
    
    info.tid = [_datalist[indexPath.row] objectForKey:@"tid"] ;
    
    info.title = [_datalist[indexPath.row] objectForKey:@"classname"];
    
    [self presentViewController:info animated:YES completion:nil];
    
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

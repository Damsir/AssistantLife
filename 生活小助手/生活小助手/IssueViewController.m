//
//  IssueViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/21.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "IssueViewController.h"
#import "issueInfoViewController.h"
#import "issueTwoViewController.h"

@interface IssueViewController () < UICollectionViewDataSource , UICollectionViewDelegate ,PostDataDelegate >

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,strong) NSArray *datalist;

@property (nonatomic,assign) BOOL isfresh;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"user"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录后发布" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"launch"];
        
        [self configUI];
    }
    
}
-(void)configUI
{
    
    self.navigationItem.title = @"发布";
    
    CGSize size = CGSizeMake((WIDEMAX-30)/2.0, 40);
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    flow.itemSize = size ;
    
    flow.minimumLineSpacing = 10 ;
    
    flow.minimumInteritemSpacing = 5 ;
    
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    flow.headerReferenceSize = CGSizeMake(20, 80);
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, HEIGHRMAX-64) collectionViewLayout:flow];
    
    self.collection.backgroundColor = [UIColor colorWithWhite:0.800 alpha:0.500];
    
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"celldd"];
    
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lulu"];
    
    self.collection.delegate = self ;
    
    self.collection.dataSource = self ;
    
    self.collection.showsVerticalScrollIndicator = NO ;
    
    [self.view addSubview:self.collection];
    
    [self refresh];
    
    self.collection.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self refresh];
        
    }];
    
   }

-(void)refresh
{
     NSDictionary *dicurl = @{@"a":@"classtype_p",@"pid":@"1"};
    
    PostData *postdata = [[PostData alloc]initWithURL:regis_API andDic:dicurl];
    
    postdata.delegate = self ;
    
    [self.view showJUHUAWithBool:YES];
    
}

-(void)recieveData:(NSArray *)dicData
{
    
    self.datalist = dicData ;
    
    [self.collection reloadData];
    
    [self.view showJUHUAWithBool:NO];
    
    [self.collection.header endRefreshing];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.datalist.count ;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [[self.datalist[section] objectForKey:@"c"] count];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"celldd" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    NSArray *data = [self.datalist[indexPath.section] objectForKey:@"c"] ;
    
    NSArray *views = [cell.contentView subviews];
    
    for (UIView *view in views) {
        
        [view removeFromSuperview];
    }
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor =[UIColor whiteColor];
    
    view.frame = CGRectMake(1,1, cell.frame.size.width-2, cell.frame.size.height-2);
    
    [cell.contentView addSubview:view];
    
    [cell.contentView sendSubviewToBack:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
    
    label.text = [data[indexPath.row] objectForKey:@"classname"];
    
    label.textColor = [UIColor blackColor];
    
    label.textAlignment = NSTextAlignmentCenter ;
    
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    
    [view addSubview:label];

    return cell;
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.datalist[indexPath.section];
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lulu" forIndexPath:indexPath];
    
    NSArray *arr = [view subviews];
    
    for (id obj in arr) {
        
        [obj removeFromSuperview];
        
    }
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    
    imageview.layer.cornerRadius = 30 ;
    
    imageview.layer.masksToBounds = YES ;
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http_APi,dic[@"appico"]]] placeholderImage:[UIImage imageNamed:@"sunshine-icon"]];
    
    [view addSubview:imageview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+10,imageview.frame.origin.y + 15 , 200, 30)];
    
    label.text = dic[@"classname"] ;
    
    label.textColor = [UIColor blackColor];
    
    [view addSubview:label];
    
    return view;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *tid = [self.datalist[indexPath.section] objectForKey:@"tid"];
    
    NSArray *arr = [self.datalist[indexPath.section] objectForKey:@"c"];
    
    if([tid isEqualToString:@"45"])
    {
        issueInfoViewController *info = [[issueInfoViewController alloc]init];
        
        info.tid = [arr[indexPath.row] objectForKey:@"tid"];
        
        [self.navigationController pushViewController:info animated:YES];
        
    }
    else
    {
        issueTwoViewController *two = [[issueTwoViewController alloc]init];
        
        two.tid = [arr[indexPath.row] objectForKey:@"tid"];
        
        two.title = [arr[indexPath.row] objectForKey:@"classname"] ;
        
        [self.navigationController pushViewController:two animated:YES];
        
    }

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

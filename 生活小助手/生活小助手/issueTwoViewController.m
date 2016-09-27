//
//  issueTwoViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/5.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "issueTwoViewController.h"
#import "issueInfoViewController.h"

@interface issueTwoViewController () < UICollectionViewDelegate , UICollectionViewDataSource,PostDataDelegate >

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,strong) NSArray *data;
@end

@implementation issueTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    
    NSDictionary *dic = @{@"a":@"classtype_p",@"pid":self.tid};
    
    PostData *postdataa =[[ PostData alloc]initWithURL:regis_API andDic:dic];
    
    postdataa.delegate = self ;
    
}

-(void)recieveData:(NSArray *)dicData
{
    
    self.data = dicData ;
    
    [self.collection reloadData];
}

-(void)configUI
{
    self.navigationItem.title = self.title;
    
    CGSize size = CGSizeMake((WIDEMAX-30)/2.0, 40);
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    flow.itemSize = size ;
    
    flow.minimumLineSpacing = 10 ;
    
    flow.minimumInteritemSpacing = 5 ;
    
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, HEIGHRMAX-64) collectionViewLayout:flow];
    
    self.collection.delegate = self ;
    
    self.collection.dataSource = self ;
    
    self.collection.showsVerticalScrollIndicator = NO ;
    
    self.collection.backgroundColor = [UIColor colorWithWhite:0.800 alpha:0.500];
    
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellddd"];
    
    [self.view addSubview:self.collection];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellddd" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
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
    
    label.text = [self.data[indexPath.row] objectForKey:@"classname"];
    
    label.textColor = [UIColor blackColor];
    
    label.textAlignment = NSTextAlignmentCenter ;
    
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    
    [view addSubview:label];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    issueInfoViewController *info = [[issueInfoViewController alloc]init];
    
    info.tid = [self.data[indexPath.row] objectForKey:@"tid"];
    
    [self.navigationController pushViewController:info animated:YES];
    
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

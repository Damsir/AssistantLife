//
//  InfoOption.m
//  生活小助手
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "InfoOption.h"

@implementation InfoOption
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120, HEIGHRMAX)];
        
        _table.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        
        _table.delegate = self ;
        
        _table.dataSource = self ;
        
        [self addSubview:_table];
        
    }
    return self ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30 ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    
    cell.backgroundColor = [UIColor colorWithRed:0.000 green:0.600 blue:0.800 alpha:1.000];
    cell.textLabel.text = @"秦时明月";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  InfoTableViewCell.m
//  生活小助手
//
//  Created by qianfeng on 15/11/25.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        [self configUI];
        
    }
    return self ;
}



-(void)configUI
{
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
    
    [self.contentView addSubview:self.imageview];
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+10, self.imageview.frame.origin.y, WIDEMAX-(self.imageview.frame.size.width+15), 30)];
    self.title.textColor = [UIColor blackColor];
    self.title.font = [UIFont systemFontOfSize:22];
    [self.contentView addSubview:self.title];
    
    self.address = [[UILabel alloc]initWithFrame:CGRectMake(self.title.frame.origin.x, CGRectGetMaxY(self.title.frame), 200, 20)];
    self.address.textColor = [UIColor blackColor];
    self.address.font = [UIFont systemFontOfSize:17] ;
    [self.contentView addSubview:self.address];
    
    self.quyu = [[UILabel alloc]initWithFrame:CGRectMake(self.title.frame.origin.x, CGRectGetMaxY(self.address.frame), 100, 20)];
    self.quyu.textColor = [UIColor blackColor];
    self.quyu.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.quyu];
    
    self.data = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.quyu.frame)+10, self.quyu.frame.origin.y, 150, 20)];
    self.data.textColor = [UIColor blackColor];
    self.data.font = [UIFont systemFontOfSize:17] ;
    [self.contentView addSubview:self.data];
    
}



















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

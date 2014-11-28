//
//  CustomMoreCell.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/17.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//

#import "CustomMoreCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CustomMoreCell ()

@end
@implementation CustomMoreCell

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:236/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    }
    return self;
}
- (void)awakeFromNib {
    _leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
    _leftIV.center = CGPointMake(30, (HEIGHT-92)/18);
    _textLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    _textLb.center = CGPointMake(115, (HEIGHT-92)/18);
    _textLb.textAlignment = NSTextAlignmentLeft;
    _textLb.font = [UIFont systemFontOfSize:18];
    
    _indicatorIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 23)];
    _indicatorIV.center = CGPointMake(WIDTH-30, (HEIGHT-92)/18);
    _indicatorIV.image = [UIImage imageNamed:@"cell_jiantou"];
    
    [self.contentView addSubview:_leftIV];
    [self.contentView addSubview:_textLb];
    [self.contentView addSubview:_indicatorIV];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

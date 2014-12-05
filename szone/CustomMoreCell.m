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
    _leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, HEIGHT/25, HEIGHT/25)];
    _leftIV.center = CGPointMake(WIDTH/11, (HEIGHT-92)/18);
    _textLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2.5, 30)];
    _textLb.center = CGPointMake(WIDTH/2.8, (HEIGHT-92)/18);
    _textLb.textAlignment = NSTextAlignmentLeft;
    _textLb.font = [UIFont systemFontOfSize:HEIGHT/32];
    
    _indicatorIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, HEIGHT/44, HEIGHT/27)];
    _indicatorIV.center = CGPointMake(WIDTH/1.08, (HEIGHT-92)/18);
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

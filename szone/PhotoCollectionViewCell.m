//
//  PhotoCollectionViewCell.m
//  szone
//
//  Created by zhuyq-MacBook Pro on 14/12/1.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;   
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)awakeFromNib {
    UIImageView *selectedIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedColleView"]];
    selectedIV.frame = CGRectMake(40, 40, 12, 12);
    [self addSubview:selectedIV];
    
}

- (instancetype)init
{
    self = [super init];
    return self;
}


@end

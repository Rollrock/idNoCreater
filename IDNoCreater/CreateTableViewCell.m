//
//  CreateTableViewCell.m
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/4.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "CreateTableViewCell.h"
#import "UILabel+Copy.h"

@interface CreateTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *NOLab;


@end

@implementation CreateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCell:(NSString*)str
{
    self.NOLab.text = str;
    self.NOLab.isCopyable = YES;
}

@end

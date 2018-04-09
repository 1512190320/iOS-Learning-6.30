//
//  ItemCell.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/24.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 20;
    frame.size.width -= 20;
    [super setFrame:frame];
}


-(IBAction)showImage:(id)sender{
    if(self.actionBlock){
        self.actionBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

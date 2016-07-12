//
//  CollectionViewCell.m
//  QuicPic
//
//  Created by Andrew Dulle on 7/11/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (void)prepareForReuse{
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor lightGrayColor]];
    [self setSelectedBackgroundView:selectedBackgroundView];
    
    UIView * backgroundView = [[UIView alloc] init];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundView:backgroundView];    
}


@end

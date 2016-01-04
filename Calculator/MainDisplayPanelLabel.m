//
//  MainDisplayPanelLabel.m
//  Calculator
//
//  Created by Julia Vashchenko on 1/4/16.
//  Copyright © 2016 Julia Vashchenko. All rights reserved.
//

#import "MainDisplayPanelLabel.h"

@implementation MainDisplayPanelLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// typedef struct { CGFloat top, left , bottom, right ; } UIEdgeInsets;

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {10, 5, 10, 10};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end

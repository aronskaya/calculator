//
//  CALayer+XibConfiguration.m
//  Calculator
//
//  Created by Julia Vashchenko on 1/4/16.
//  Copyright © 2016 Julia Vashchenko. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer(XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

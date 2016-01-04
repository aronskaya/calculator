//
//  CALayer+XibConfiguration.h
//  Calculator
//
//  Created by Julia Vashchenko on 1/4/16.
//  Copyright © 2016 Julia Vashchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;

@end

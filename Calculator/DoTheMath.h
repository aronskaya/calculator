//
//  DoTheMath.h
//  Calculator
//
//  Created by Julia Vashchenko on 12/27/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TheSign) {
    PLUS,
    MINUS,
    DIVIDE,
    MULTIPLY,
    PERCENT,
    NONE,
};

@interface DoTheMath : NSObject

@property (strong, nonatomic) id result;

-(double)firstNumber:(NSNumber *)firstNumber sign:(TheSign)currentSign secondNumber:(NSNumber *)secondNumber;

@end

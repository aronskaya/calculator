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

@interface JVPDoTheMath : NSObject

-(NSDecimalNumber *)firstNumber:(NSDecimalNumber *)firstNumber sign:(TheSign)currentSign secondNumber:(NSDecimalNumber *)secondNumber;

@end

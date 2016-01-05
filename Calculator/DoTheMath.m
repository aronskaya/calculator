//
//  DoTheMath.m
//  Calculator
//
//  Created by Julia Vashchenko on 12/27/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import "DoTheMath.h"
#import "CalculatorVC.h"

@implementation DoTheMath
-(double)firstNumber:(NSNumber *)firstNumber sign:(TheSign)currentSign secondNumber:(NSNumber *)secondNumber {
    double result;
    
    switch (currentSign) {
        case PLUS:
            result = firstNumber.doubleValue + secondNumber.doubleValue;
             return result;
            break;
            
        case MINUS:
            result = firstNumber.doubleValue - secondNumber.doubleValue;
             return result;
            break;
            
        case DIVIDE:
            result = firstNumber.doubleValue / secondNumber.doubleValue;
             return result;
            break;
            
        case MULTIPLY:
            result = firstNumber.doubleValue * secondNumber.doubleValue;
             return result;
            break;
            
        case PERCENT:
            if ([secondNumber isEqual:@0]) {
                result = (firstNumber.doubleValue / 100);
                return result;
                break;
            } else {
                result = (firstNumber.doubleValue / 100 * secondNumber.doubleValue);
                return result;
            }
            
        case NONE:
            return secondNumber.doubleValue;
            break;

    }

}




@end

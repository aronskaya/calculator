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
    
    switch (currentSign) {
        case PLUS:
             return (firstNumber.doubleValue + secondNumber.doubleValue);
            break;
            
        case MINUS:
             return (firstNumber.doubleValue - secondNumber.doubleValue);
            break;
            
        case DIVIDE:
             return (firstNumber.doubleValue / secondNumber.doubleValue);
            break;
            
        case MULTIPLY:
             return (firstNumber.doubleValue * secondNumber.doubleValue);
            break;
            
        case PERCENT:
             return (firstNumber.doubleValue + secondNumber.doubleValue);
            break;
            
    }

}




@end

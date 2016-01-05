//
//  DoTheMath.m
//  Calculator
//
//  Created by Julia Vashchenko on 12/27/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import "JVPDoTheMath.h"
#import "JVPCalculatorVC.h"

@implementation JVPDoTheMath
-(NSDecimalNumber *)firstNumber:(NSDecimalNumber *)firstNumber sign:(TheSign)currentSign secondNumber:(NSDecimalNumber *)secondNumber {
    
    NSDecimalNumber *hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
    
    switch (currentSign) {
        case PLUS:
            return [firstNumber decimalNumberByAdding:secondNumber];
            break;
            
        case MINUS:
            return [firstNumber decimalNumberBySubtracting:secondNumber];
            break;
            
        case DIVIDE:
            return [firstNumber decimalNumberByDividingBy:secondNumber];
            break;
            
        case MULTIPLY:
            return [firstNumber decimalNumberByMultiplyingBy:secondNumber];
            break;
            
        case PERCENT:
            if ([secondNumber compare:[NSDecimalNumber zero]] == NSOrderedSame) {
                return [firstNumber decimalNumberByDividingBy:hundred];
            } else {
                return [[firstNumber decimalNumberByDividingBy:hundred]decimalNumberByMultiplyingBy:secondNumber];
            }
            break;
            
        case NONE:
            return secondNumber;
            break;
    }
}

@end

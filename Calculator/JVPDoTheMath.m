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
        case kJVPPlusSign:
            return [firstNumber decimalNumberByAdding:secondNumber];
            break;
            
        case kJVPMinusSign:
            return [firstNumber decimalNumberBySubtracting:secondNumber];
            break;
            
        case kJVPDivideSign:
            return [firstNumber decimalNumberByDividingBy:secondNumber];
            break;
            
        case kJVPMultiplySign:
            return [firstNumber decimalNumberByMultiplyingBy:secondNumber];
            break;
            
        case kJVPPercentSign:
            if ([secondNumber compare:[NSDecimalNumber zero]] == NSOrderedSame) {
                return [firstNumber decimalNumberByDividingBy:hundred];
            } else {
                return [[firstNumber decimalNumberByDividingBy:hundred]decimalNumberByMultiplyingBy:secondNumber];
            }
            break;
            
        case kJVPNoneSign:
            return secondNumber;
            break;
    }
}

@end

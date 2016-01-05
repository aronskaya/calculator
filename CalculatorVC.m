//
//  CalculatorVC.m
//  Calculator
//
//  Created by Julia Vashchenko on 12/25/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import "CalculatorVC.h"

@interface CalculatorVC ()

@end

@implementation CalculatorVC

@synthesize numberFormatter;
@synthesize smallBigNumberFormatter;
@synthesize numberString;
@synthesize result;
@synthesize backupResult;
@synthesize output;
@synthesize firstNumber;
@synthesize secondNumber;
@synthesize backupSecondNumber;
@synthesize zero;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setting initial values
    
    output.text = @"0";
    numberString = @"";
    zero = [NSDecimalNumber zero];
    firstNumber = zero;
    secondNumber = zero;
    backupResult = zero;
    backupSecondNumber = zero;
    self.doTheMath = [[DoTheMath alloc]init];
    result = zero;
    lastButtonPressed = OPEN_APP_BUTTON;
    currentSign = NONE;
    
    //configuring an NSNumberFormatter for output of numbers less than 100 000 000
    
    numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter.usesGroupingSeparator = YES;
    numberFormatter.groupingSeparator = @" ";
    numberFormatter.decimalSeparator = @".";
    numberFormatter.maximumFractionDigits = 30;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.positiveInfinitySymbol = @"Not a number";
    numberFormatter.negativeInfinitySymbol = @"Not a number";
    
    //configuring an NSNumberFormatter for output of numbers more than 100 000 000
    smallBigNumberFormatter = [[NSNumberFormatter alloc]init];
    smallBigNumberFormatter.numberStyle = kCFNumberFormatterScientificStyle;
    smallBigNumberFormatter.usesGroupingSeparator = YES;
    smallBigNumberFormatter.groupingSeparator = @" ";
    smallBigNumberFormatter.decimalSeparator = @".";
    smallBigNumberFormatter.maximumFractionDigits = 30;
    smallBigNumberFormatter.minimumFractionDigits = 0;
    smallBigNumberFormatter.exponentSymbol = @"e";
    smallBigNumberFormatter.positiveInfinitySymbol = @"Not a number";
    smallBigNumberFormatter.negativeInfinitySymbol = @"Not a number";
    
    //configuring the display label
    output.numberOfLines = 1;
    output.adjustsFontSizeToFitWidth = YES;
    output.minimumScaleFactor = 8.0/[UIFont labelFontSize];
}

-(NSString *)stringForCurrentBackupResult {
    
    NSNumberFormatter *selectedNumberFormatter;
    NSDecimalNumber *smallNumber = [NSDecimalNumber decimalNumberWithString:@"0.0000000000001"];
    NSDecimalNumber *bigNumber = [NSDecimalNumber decimalNumberWithString:@"1000000000000"];
    
    //getting absolute value of a number
    NSDecimal decimalStruct = backupResult.decimalValue;
    unsigned int integer = 0;
    decimalStruct._isNegative = integer;
    NSDecimalNumber *positiveNumber = [NSDecimalNumber decimalNumberWithDecimal:decimalStruct];
    
    
    //choosing the appropriate formatter
    if (([positiveNumber compare:bigNumber] == NSOrderedDescending) || ([positiveNumber compare:bigNumber] == NSOrderedSame) || ([positiveNumber compare:smallNumber] == NSOrderedAscending) || ([positiveNumber compare:smallNumber] == NSOrderedSame)) {
        selectedNumberFormatter = smallBigNumberFormatter;
    }
    else {
        selectedNumberFormatter = numberFormatter;
    }
    
    //generating string
    NSString *resultString = [selectedNumberFormatter stringFromNumber:backupResult];
    return resultString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSString *)appendingFigure:(NSString *)figureString {
    if ([numberString isEqualToString:@"0"]) {
        numberString = figureString;
    } else {
        numberString = [numberString stringByAppendingString:figureString];
    }
    output.text = numberString;
    lastButtonPressed = FIGURE_BUTTON;
    return numberString;
}

-(NSDecimalNumber *)numberFromString:(NSString *)receivedNumberString {
    return [NSDecimalNumber decimalNumberWithString:receivedNumberString];
}

-(void)freshStartWithSign:(TheSign)sign andButton:(LastButtonPressed)button {
    firstNumber = backupResult;
    numberString = @"";
    currentSign = sign;
    lastButtonPressed = button;
}

- (IBAction)zeroButton:(id)sender {
    if (![numberString isEqualToString:@"0"]) {
        [self appendingFigure:@"0"];
        }
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)oneButton:(id)sender {
    [self appendingFigure:@"1"];
}

- (IBAction)twoButton:(id)sender {
    [self appendingFigure:@"2"];
}

- (IBAction)threeButton:(id)sender {
    [self appendingFigure:@"3"];
}

- (IBAction)fourButton:(id)sender {
    [self appendingFigure:@"4"];
}

- (IBAction)fiveButton:(id)sender {
    [self appendingFigure:@"5"];
}

- (IBAction)sixButton:(id)sender {
    [self appendingFigure:@"6"];
}

- (IBAction)sevenButton:(id)sender {
    [self appendingFigure:@"7"];
}

- (IBAction)eightButton:(id)sender {
    [self appendingFigure:@"8"];
}

- (IBAction)nineButton:(id)sender {
    [self appendingFigure:@"9"];
}

- (IBAction)commaButton:(id)sender {
    
    if (([numberString isEqualToString:@""]) || (lastButtonPressed == PLUS_BUTTON) || (lastButtonPressed == MINUS_BUTTON) || (lastButtonPressed == DIVIDE_BUTTON) || (lastButtonPressed == MULTIPLY_BUTTON)) {
        numberString = @"0.";
        output.text = numberString;
    }
    
    if (![numberString containsString:@"."]) {
        [self appendingFigure:@"."];
    }
}


- (IBAction)plusSign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            
            //standard calculations, e.g. 10 + 3 = ...
            if ([firstNumber compare:zero] == NSOrderedSame) {
                firstNumber = [self numberFromString:numberString];
                numberString = @"";
            }
            
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                secondNumber = [self numberFromString:numberString];
                result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
                backupResult = result;
                numberString = [self stringForCurrentBackupResult];
                output.text = numberString;
                
                firstNumber = backupResult;
                numberString = @"";
            }
            currentSign = PLUS;
            lastButtonPressed = PLUS_BUTTON;
            
        case MINUS_BUTTON:
        case MULTIPLY_BUTTON:
        case DIVIDE_BUTTON:
        case PERCENT_BUTTON:
            currentSign = PLUS;
            lastButtonPressed = PLUS_BUTTON;
            break;
        case PLUS_BUTTON:
            break;
        case EQUAL_BUTTON:
        case OPEN_APP_BUTTON:
            [self freshStartWithSign:PLUS andButton:PLUS_BUTTON];
    }
    
}

- (IBAction)minusSign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
                        //standard calculations, e.g. 10 + 3 = ...
            if ([firstNumber compare:zero] == NSOrderedSame) {
                firstNumber = [self numberFromString:numberString];
                numberString = @"";
            }
                        //continuous calculations, e.g. 10 + 3 + 5...
            else {
                secondNumber = [self numberFromString:numberString];
                result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
                backupResult = result;
                numberString = [self stringForCurrentBackupResult];
                output.text = numberString;
                
                firstNumber = backupResult;
                numberString = @"";
            }
            currentSign = MINUS;
            lastButtonPressed = MINUS_BUTTON;
            
        case PLUS_BUTTON:
        case MULTIPLY_BUTTON:
        case DIVIDE_BUTTON:
        case PERCENT_BUTTON:
            currentSign = MINUS;
            lastButtonPressed = MINUS_BUTTON;
            break;
            
        case MINUS_BUTTON:
            break;
            
        case EQUAL_BUTTON:
        case OPEN_APP_BUTTON:
            [self freshStartWithSign:MINUS andButton:MINUS_BUTTON];
    }
}

- (IBAction)divisionSign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            //standard calculations, e.g. 10 + 3 = ...
            if ([firstNumber compare:zero] == NSOrderedSame) {
                firstNumber = [self numberFromString:numberString];
                numberString = @"";
            }
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                secondNumber = [self numberFromString:numberString];
                result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
                backupResult = result;
                numberString = [self stringForCurrentBackupResult];
                output.text = numberString;
                
                firstNumber = backupResult;
                numberString = @"";
            }
            currentSign = DIVIDE;
            lastButtonPressed = DIVIDE_BUTTON;
        case PLUS_BUTTON:
        case MULTIPLY_BUTTON:
        case MINUS_BUTTON:
        case PERCENT_BUTTON:
            currentSign = DIVIDE;
            lastButtonPressed = DIVIDE_BUTTON;
            break;
        case DIVIDE_BUTTON:
            break;
        case EQUAL_BUTTON:
        case OPEN_APP_BUTTON:
            [self freshStartWithSign:DIVIDE andButton:DIVIDE_BUTTON];
    }
}

- (IBAction)multiplySign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            //standard calculations, e.g. 10 + 3 = ...
            if ([firstNumber compare:zero] == NSOrderedSame) {
                firstNumber = [self numberFromString:numberString];
                numberString = @"";
            }
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                secondNumber = [self numberFromString:numberString];
                result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
                backupResult = result;
                numberString = [self stringForCurrentBackupResult];
                output.text = numberString;
                
                firstNumber = backupResult;
                numberString = @"";
            }
            currentSign = MULTIPLY;
            lastButtonPressed = MULTIPLY_BUTTON;
            break;
        case PLUS_BUTTON:
        case MINUS_BUTTON:
        case DIVIDE_BUTTON:
        case PERCENT_BUTTON:
            currentSign = MULTIPLY;
            lastButtonPressed = MULTIPLY_BUTTON;
            break;
        case MULTIPLY_BUTTON:
            break;
        case EQUAL_BUTTON:
        case OPEN_APP_BUTTON:
            [self freshStartWithSign:MULTIPLY andButton:MULTIPLY_BUTTON];
    }
    
}

- (IBAction)ACButton:(id)sender {
    firstNumber = zero;
    secondNumber = zero;
    numberString = @"";
    output.text = @"0";
    backupResult = zero;
    result = zero;
    currentSign = NONE;
    lastButtonPressed = OPEN_APP_BUTTON;
    
}

- (IBAction)changeSignButton:(id)sender {
    if (![numberString containsString:@"-"]) {
        numberString = [NSString stringWithFormat:@"-%@", numberString];
    }
    else {
        numberString = [numberString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    output.text = numberString;
    lastButtonPressed = CHANGE_BUTTON;
}

#pragma mark - Current Working Point

- (IBAction)percentButton:(id)sender {
    currentSign = PERCENT;
    
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
        case PERCENT_BUTTON:
            
            if ([firstNumber compare:zero] == NSOrderedSame) {
                firstNumber = [self numberFromString:numberString];
                secondNumber = zero;
                
                result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
                backupResult = result;
                numberString = [self stringForCurrentBackupResult];
                output.text = numberString;
                firstNumber = backupResult;
                numberString = @"";
            }
            else {
                secondNumber = [self numberFromString:numberString];
                result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
                backupResult = result;
                numberString = [self stringForCurrentBackupResult];
                output.text = numberString;
                firstNumber = backupResult;
                numberString = @"";
            }
        case PLUS_BUTTON:
        case MINUS_BUTTON:
        case DIVIDE_BUTTON:
        case MULTIPLY_BUTTON:
            break;
        case EQUAL_BUTTON:
        case OPEN_APP_BUTTON:
            [self freshStartWithSign:MULTIPLY andButton:MULTIPLY_BUTTON];
    }
}

- (IBAction)equalSign:(id)sender {
    
    switch (lastButtonPressed) {
            
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            secondNumber = [self numberFromString:numberString];
            result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
            backupResult = result;
            backupSecondNumber = secondNumber;
            
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            
            firstNumber = zero;
            secondNumber = zero;
            break;
            
        case EQUAL_BUTTON:
            secondNumber = backupSecondNumber;
            firstNumber = backupResult;
            result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
            backupResult = result;
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            firstNumber = zero;
            secondNumber = zero;
            break;
            
        case PLUS_BUTTON:
        case MULTIPLY_BUTTON:
        case DIVIDE_BUTTON:
        case MINUS_BUTTON:
        case PERCENT_BUTTON:
            secondNumber = firstNumber;
            result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
            backupResult = result;
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            
            
        case OPEN_APP_BUTTON:
            result = zero;
            backupResult = result;
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            break;
            
    }
    lastButtonPressed = EQUAL_BUTTON;
}

@end

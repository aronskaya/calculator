//
//  CalculatorVC.m
//  Calculator
//
//  Created by Julia Vashchenko on 12/25/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import "JVPCalculatorVC.h"

@interface JVPCalculatorVC ()

@end

@implementation JVPCalculatorVC

@synthesize regularNumberFormatter;
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
    
    self.doTheMath = [[JVPDoTheMath alloc]init];
    output.text = @"0";
    numberString = @"";
    zero = [NSDecimalNumber zero];
    firstNumber = zero;
    secondNumber = zero;
    backupResult = zero;
    backupSecondNumber = zero;
    result = zero;
    lastButtonPressed = kJVPOpenAppButton;
    currentSign = kJVPNoneSign;
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:11 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    [NSDecimalNumber setDefaultBehavior:handler];
    
    //configuring an NSNumberFormatter for output of numbers less than 100 000 000
    
    regularNumberFormatter = [[NSNumberFormatter alloc] init];
    regularNumberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    regularNumberFormatter.usesGroupingSeparator = YES;
    regularNumberFormatter.groupingSeparator = @" ";
    regularNumberFormatter.decimalSeparator = @".";
    regularNumberFormatter.maximumFractionDigits = 15;
    regularNumberFormatter.minimumFractionDigits = 0;
    
    //configuring an NSNumberFormatter for output of numbers more than 100 000 000
    smallBigNumberFormatter = [[NSNumberFormatter alloc]init];
    smallBigNumberFormatter.numberStyle = kCFNumberFormatterScientificStyle;
    smallBigNumberFormatter.usesGroupingSeparator = YES;
    smallBigNumberFormatter.groupingSeparator = @" ";
    smallBigNumberFormatter.decimalSeparator = @".";
    smallBigNumberFormatter.maximumFractionDigits = 15;
    smallBigNumberFormatter.minimumFractionDigits = 0;
    smallBigNumberFormatter.exponentSymbol = @"e";
    
    //configuring the display label
    output.numberOfLines = 1;
    output.lineBreakMode = NSLineBreakByClipping;
    output.adjustsFontSizeToFitWidth = YES;
    output.minimumScaleFactor = 7.0/[UIFont labelFontSize];
}

-(NSString *)stringForCurrentBackupResult {
    //checking for division on zero and other mathematical errors
    if ([backupResult compare:[NSDecimalNumber notANumber]] == NSOrderedSame) {
        return @"Error";
    }
    
    //specifying conditions when regular or scientific format of output is used
    NSNumberFormatter *selectedNumberFormatter;
    NSDecimalNumber *smallNumber = [NSDecimalNumber decimalNumberWithString:@"0.0000000001"];
    NSDecimalNumber *bigNumber = [NSDecimalNumber decimalNumberWithString:@"999999999999"];
    
    //getting absolute value of a number
    NSDecimal decimalStruct = backupResult.decimalValue;
    unsigned int integer = 0;
    decimalStruct._isNegative = integer;
    NSDecimalNumber *positiveNumber = [NSDecimalNumber decimalNumberWithDecimal:decimalStruct];
    
    //choosing the appropriate formatter
    if (([positiveNumber compare:zero] == NSOrderedDescending) && (([positiveNumber compare:bigNumber] == NSOrderedDescending) || ([positiveNumber compare:bigNumber] == NSOrderedSame) || ([positiveNumber compare:smallNumber] == NSOrderedAscending) || ([positiveNumber compare:smallNumber] == NSOrderedSame))) {
        
        selectedNumberFormatter = smallBigNumberFormatter;
    }
    else {
        selectedNumberFormatter = regularNumberFormatter;
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
    lastButtonPressed = kJVPFigureButton;
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
    lastButtonPressed = kJVPFigureButton;
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
    
    if (([numberString isEqualToString:@""]) || ([numberString isEqualToString:@"0"]) || (lastButtonPressed == kJVPPlusButton) || (lastButtonPressed == kJVPMinusButton) || (lastButtonPressed == kJVPDivideButton) || (lastButtonPressed == kJVPMultiplyButton)) {
        numberString = @"0.";
        output.text = numberString;
    }
    
    if (![numberString containsString:@"."]) {
        [self appendingFigure:@"."];
    }
}


- (IBAction)plusSign:(id)sender {
    switch (lastButtonPressed) {
        case kJVPFigureButton:
        case kJVPChangeButton:
            
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
            currentSign = kJVPPlusSign;
            lastButtonPressed = kJVPPlusButton;
            
        case kJVPMinusButton:
        case kJVPMultiplyButton:
        case kJVPDivideButton:
        case kJVPPercentButton:
            currentSign = kJVPPlusSign;
            lastButtonPressed = kJVPPlusButton;
            break;
        case kJVPPlusButton:
            break;
        case kJVPEqualButton:
        case kJVPOpenAppButton:
            [self freshStartWithSign:kJVPPlusSign andButton:kJVPPlusButton];
    }
    
}

- (IBAction)minusSign:(id)sender {
    switch (lastButtonPressed) {
        case kJVPFigureButton:
        case kJVPChangeButton:
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
            currentSign = kJVPMinusSign;
            lastButtonPressed = kJVPMinusButton;
            
        case kJVPPlusButton:
        case kJVPMultiplyButton:
        case kJVPDivideButton:
        case kJVPPercentButton:
            currentSign = kJVPMinusSign;
            lastButtonPressed = kJVPMinusButton;
            break;
            
        case kJVPMinusButton:
            break;
            
        case kJVPEqualButton:
        case kJVPOpenAppButton:
            [self freshStartWithSign:kJVPMinusSign andButton:kJVPMinusButton];
    }
}

- (IBAction)divisionSign:(id)sender {
    switch (lastButtonPressed) {
        case kJVPFigureButton:
        case kJVPChangeButton:
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
            currentSign = kJVPDivideSign;
            lastButtonPressed = kJVPDivideButton;
        case kJVPPlusButton:
        case kJVPMultiplyButton:
        case kJVPMinusButton:
        case kJVPPercentButton:
            currentSign = kJVPDivideSign;
            lastButtonPressed = kJVPDivideButton;
            break;
        case kJVPDivideButton:
            break;
        case kJVPEqualButton:
        case kJVPOpenAppButton:
            [self freshStartWithSign:kJVPDivideSign andButton:kJVPDivideButton];
    }
}

- (IBAction)multiplySign:(id)sender {
    switch (lastButtonPressed) {
        case kJVPFigureButton:
        case kJVPChangeButton:
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
            currentSign = kJVPMultiplySign;
            lastButtonPressed = kJVPMultiplyButton;
            break;
        case kJVPPlusButton:
        case kJVPMinusButton:
        case kJVPDivideButton:
        case kJVPPercentButton:
            currentSign = kJVPMultiplySign;
            lastButtonPressed = kJVPMultiplyButton;
            break;
        case kJVPMultiplyButton:
            break;
        case kJVPEqualButton:
        case kJVPOpenAppButton:
            [self freshStartWithSign:kJVPMultiplySign andButton:kJVPMultiplyButton];
    }
    
}

- (IBAction)ACButton:(id)sender {
    firstNumber = zero;
    secondNumber = zero;
    numberString = @"";
    output.text = @"0";
    backupResult = zero;
    result = zero;
    currentSign = kJVPNoneSign;
    lastButtonPressed = kJVPOpenAppButton;
    
}

- (IBAction)changeSignButton:(id)sender {
    if (![numberString containsString:@"-"]) {
        numberString = [NSString stringWithFormat:@"-%@", numberString];
    }
    else {
        numberString = [numberString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    output.text = numberString;
    lastButtonPressed = kJVPChangeButton;
}

#pragma mark - Current Working Point

- (IBAction)percentButton:(id)sender {
    currentSign = kJVPPercentSign;
    
    switch (lastButtonPressed) {
        case kJVPFigureButton:
        case kJVPChangeButton:
        case kJVPPercentButton:
            
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
        case kJVPPlusButton:
        case kJVPMinusButton:
        case kJVPDivideButton:
        case kJVPMultiplyButton:
            break;
        case kJVPEqualButton:
        case kJVPOpenAppButton:
            [self freshStartWithSign:kJVPPercentSign andButton:kJVPMultiplyButton];
    }
}

- (IBAction)equalSign:(id)sender {
    
    switch (lastButtonPressed) {
            
        case kJVPFigureButton:
        case kJVPChangeButton:
            secondNumber = [self numberFromString:numberString];
            result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
            backupResult = result;
            backupSecondNumber = secondNumber;
            
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            
            firstNumber = zero;
            secondNumber = zero;
            break;
            
        case kJVPEqualButton:
            secondNumber = backupSecondNumber;
            firstNumber = backupResult;
            result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
            backupResult = result;
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            firstNumber = zero;
            secondNumber = zero;
            break;
            
        case kJVPPlusButton:
        case kJVPMultiplyButton:
        case kJVPDivideButton:
        case kJVPMinusButton:
        case kJVPPercentButton:
            secondNumber = firstNumber;
            result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
            backupResult = result;
            backupSecondNumber = secondNumber;
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            firstNumber = zero;
            secondNumber = zero;
            break;
            
        case kJVPOpenAppButton:
            result = zero;
            backupResult = result;
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            break;
            
    }
    lastButtonPressed = kJVPEqualButton;

}

@end

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setting initial values
    
    self.output.text = @"0";
    self.numberString = @"";
    self.firstNumber = [NSNumber numberWithDouble:0.0];
    self.secondNumber = [NSNumber numberWithDouble:0.0];
    self.backupResult = [NSNumber numberWithDouble:0.0];
    self.doTheMath = [[DoTheMath alloc]init];
    result = 0.0;
    
    //configuring an NSNumberFormatter for output of numbers less than 100 000 000
    
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    self.numberFormatter.usesGroupingSeparator = YES;
    self.numberFormatter.groupingSeparator = @" ";
    self.numberFormatter.decimalSeparator = @".";
    self.numberFormatter.maximumFractionDigits = 20;
    self.numberFormatter.minimumFractionDigits = 0;
    
    //configuring an NSNumberFormatter for output of numbers more than 100 000 000
    
    self.bigNumberFormatter = [[NSNumberFormatter alloc]init];
    self.bigNumberFormatter.numberStyle = kCFNumberFormatterScientificStyle;
    self.bigNumberFormatter.usesGroupingSeparator = YES;
    self.bigNumberFormatter.groupingSeparator = @" ";
    self.bigNumberFormatter.decimalSeparator = @".";
    self.bigNumberFormatter.maximumFractionDigits = 50;
    self.bigNumberFormatter.minimumFractionDigits = 0;
    self.bigNumberFormatter.exponentSymbol = @"e";
    
    //configuring the display label
    self.output.numberOfLines = 1;
    self.output.adjustsFontSizeToFitWidth = YES;
    self.output.minimumScaleFactor = 8.0/[UIFont labelFontSize];
}

-(NSNumberFormatter *)numberFormatterForCurrentBackupResult {
    NSNumberFormatter *selectedNumberFormatter = self.backupResult.floatValue > 100000000.00 ?
                               self.bigNumberFormatter : self.numberFormatter;
    return selectedNumberFormatter;
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
    self.numberString = [self.numberString stringByAppendingString:figureString];
    self.output.text = self.numberString;
    lastButtonPressed = FIGURE_BUTTON;
    return self.numberString;
}

-(NSNumber *)convertedString:(NSString *)numberString {
    return [NSNumber numberWithDouble:[self.numberString doubleValue]];
}

-(void)freshStartWithSign:(TheSign)sign andButton:(LastButtonPressed)button {
    self.firstNumber = self.backupResult;
    self.numberString = @"";
    currentSign = sign;
    lastButtonPressed = button;
}

- (IBAction)zeroButton:(id)sender {
    if (![self.numberString isEqualToString:@"0"]) {
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
    
    if (([self.numberString isEqualToString:@""]) || (lastButtonPressed == PLUS_BUTTON) || (lastButtonPressed == MINUS_BUTTON) || (lastButtonPressed == DIVIDE_BUTTON) || (lastButtonPressed == MULTIPLY_BUTTON)) {
        self.numberString = @"0.";
        self.output.text = self.numberString;
    }
    
    if (![self.numberString containsString:@"."]) {
        [self appendingFigure:@"."];
    }
}


- (IBAction)plusSign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            //standard calculations, e.g. 10 + 3 = ...
            if ([self.firstNumber isEqual: @0]) {
                self.firstNumber = [self convertedString:self.numberString];
                self.numberString = @"";
            }
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                self.secondNumber = [self convertedString:self.numberString];
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.backupResult = [NSNumber numberWithDouble:result];
                self.numberString = [[self numberFormatterForCurrentBackupResult] stringFromNumber:self.backupResult];
                self.output.text = self.numberString;
                
                self.firstNumber = self.backupResult;
                self.numberString = @"";
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
            if ([self.firstNumber isEqual: @0]) {
                self.firstNumber = [self convertedString:self.numberString];
                self.numberString = @"";
            }
                        //continuous calculations, e.g. 10 + 3 + 5...
            else {
                self.secondNumber = [self convertedString:self.numberString];
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.backupResult = [NSNumber numberWithDouble:result];
                self.numberString = [[self numberFormatterForCurrentBackupResult] stringFromNumber:self.backupResult];
                self.output.text = self.numberString;
                
                self.firstNumber = self.backupResult;
                self.numberString = @"";
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
            if ([self.firstNumber isEqual: @0]) {
                self.firstNumber = [self convertedString:self.numberString];
                self.numberString = @"";
            }
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                self.secondNumber = [self convertedString:self.numberString];
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.backupResult = [NSNumber numberWithDouble:result];
                self.numberString = [[self numberFormatterForCurrentBackupResult] stringFromNumber:self.backupResult];
                self.output.text = self.numberString;
                
                self.firstNumber = self.backupResult;
                self.numberString = @"";
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
            if ([self.firstNumber isEqual: @0]) {
                self.firstNumber = [self convertedString:self.numberString];
                self.numberString = @"";
            }
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                self.secondNumber = [self convertedString:self.numberString];
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.backupResult = [NSNumber numberWithDouble:result];
                self.numberString = [[self numberFormatterForCurrentBackupResult] stringFromNumber:self.backupResult];
                self.output.text = self.numberString;
                
                self.firstNumber = self.backupResult;
                self.numberString = @"";
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
    self.firstNumber = @0;
    self.secondNumber = @0;
    self.numberString = @"";
    self.output.text = @"0";
    self.backupResult = @0;
    result = 0.0;
    lastButtonPressed = OPEN_APP_BUTTON;
    
}

- (IBAction)changeSignButton:(id)sender {
    if (![self.numberString containsString:@"-"]) {
        self.numberString = [NSString stringWithFormat:@"-%@", self.numberString];
    }
    else {
        self.numberString = [self.numberString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    self.output.text = self.numberString;
    lastButtonPressed = CHANGE_BUTTON;
}

#pragma mark - Current Working Point

- (IBAction)percentButton:(id)sender {
    currentSign = PERCENT;
    
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
        case PERCENT_BUTTON:
            
            if ([self.firstNumber isEqual:@0]) {
                self.firstNumber = [self convertedString:self.numberString];
                self.secondNumber = @0.0;
                
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.backupResult = [NSNumber numberWithDouble:result];
                self.numberString = [[self numberFormatterForCurrentBackupResult] stringFromNumber:self.backupResult];
                self.output.text = self.numberString;
                self.firstNumber = self.backupResult;
                self.numberString = @"";
            }
            else {
                self.secondNumber = [self convertedString:self.numberString];
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.backupResult = [NSNumber numberWithDouble:result];
                self.numberString = [[self numberFormatterForCurrentBackupResult] stringFromNumber:self.backupResult];
                self.output.text = self.numberString;
                self.firstNumber = self.backupResult;
                self.numberString = @"";
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
            self.secondNumber = [self convertedString:self.numberString];
            result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
            self.backupResult = [NSNumber numberWithDouble:result];
            self.numberString = [[self numberFormatterForCurrentBackupResult] stringFromNumber:self.backupResult];

            self.output.text = self.numberString;
            
            self.backupSecondNumber = self.secondNumber;
            
            self.firstNumber = @0;
            self.secondNumber = @0;
            lastButtonPressed = EQUAL_BUTTON;
            break;
            
        case EQUAL_BUTTON:
            self.secondNumber = self.backupSecondNumber;
            self.firstNumber = self.backupResult;
            result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
            self.output.text = [NSString stringWithFormat:@"%f", result];
            self.backupResult = [NSNumber numberWithDouble:result];
            lastButtonPressed = EQUAL_BUTTON;
            break;
            
        case PLUS_BUTTON:
        case MULTIPLY_BUTTON:
        case DIVIDE_BUTTON:
        case MINUS_BUTTON:
        case PERCENT_BUTTON:
            self.secondNumber = self.firstNumber;
            result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
            self.output.text = [NSString stringWithFormat:@"%f", result];
            self.backupResult = [NSNumber numberWithDouble:result];
            lastButtonPressed = EQUAL_BUTTON;
        case OPEN_APP_BUTTON:
            result = 0.0;
            self.output.text = [NSString stringWithFormat:@"%f", result];
            self.backupResult = [NSNumber numberWithDouble:result];
            lastButtonPressed = EQUAL_BUTTON;
            break;
    }
}

@end

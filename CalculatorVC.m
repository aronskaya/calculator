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
    // Do any additional setup after loading the view.
    self.output.text = @"0";
    self.numberString = @"";
    
    self.firstNumber = [NSNumber numberWithDouble:0.0];
    self.secondNumber = [NSNumber numberWithDouble:0.0];
    self.backupResult = [NSNumber numberWithDouble:0.0];
    
    self.doTheMath = [[DoTheMath alloc]init];
    result = 0.0;
    
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

//-(void)doTheMaths

-(NSString *)appendingFigure:(NSString *)figureString {
    self.numberString = [self.numberString stringByAppendingString:figureString];
    self.output.text = self.numberString;
    return self.numberString;
}

-(NSNumber *)convertedString:(NSString *)numberString {
    return [NSNumber numberWithDouble:[self.numberString doubleValue]];
}

- (IBAction)zeroButton:(id)sender {
    if (![self.numberString isEqualToString:@"0"]) {
        [self appendingFigure:@"0"];
        }
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)oneButton:(id)sender {
    [self appendingFigure:@"1"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)twoButton:(id)sender {
    [self appendingFigure:@"2"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)threeButton:(id)sender {
    [self appendingFigure:@"3"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)fourButton:(id)sender {
    [self appendingFigure:@"4"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)fiveButton:(id)sender {
    [self appendingFigure:@"5"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)sixButton:(id)sender {
    [self appendingFigure:@"6"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)sevenButton:(id)sender {
    [self appendingFigure:@"7"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)eightButton:(id)sender {
    [self appendingFigure:@"8"];
    lastButtonPressed = FIGURE_BUTTON;
}

- (IBAction)nineButton:(id)sender {
    [self appendingFigure:@"9"];
    lastButtonPressed = FIGURE_BUTTON;
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
            if ([self.secondNumber isEqualToNumber:[NSNumber numberWithDouble:0.0]]) {
                self.firstNumber = [self convertedString:self.numberString];
                self.numberString = @"";
            }
            else {
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.output.text = self.numberString;
                self.firstNumber = [NSNumber numberWithDouble:result];
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
            self.firstNumber = self.backupResult;
            self.numberString = @"";
            currentSign = PLUS;
            lastButtonPressed = PLUS_BUTTON;
    }
    
}

- (IBAction)minusSign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            if ([self.secondNumber isEqual: @0]) {
                self.firstNumber = [self convertedString:self.numberString];
                self.numberString = @"";
            }
            else {
                result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
                self.output.text = self.numberString;
                self.firstNumber = [NSNumber numberWithDouble:result];
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
            self.firstNumber = self.backupResult;
            self.numberString = @"";
            currentSign = MINUS;
            lastButtonPressed = MINUS_BUTTON;
    }
}


- (IBAction)divisionSign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            self.firstNumber = [self convertedString:self.numberString];
            self.numberString = @"";
            currentSign = DIVIDE;
            lastButtonPressed = DIVIDE_BUTTON;
            break;
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
            self.firstNumber = self.backupResult;
            self.numberString = @"";
            currentSign = DIVIDE;
            lastButtonPressed = DIVIDE_BUTTON;
    }
}

- (IBAction)multiplySign:(id)sender {
    switch (lastButtonPressed) {
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            self.firstNumber = [self convertedString:self.numberString];
            self.numberString = @"";
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
            self.firstNumber = self.backupResult;
            self.numberString = @"";
            currentSign = MULTIPLY;
            lastButtonPressed = MULTIPLY_BUTTON;
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


- (IBAction)percentButton:(id)sender {

}

- (IBAction)equalSign:(id)sender {
    
    switch (lastButtonPressed) {
            
        case FIGURE_BUTTON:
        case CHANGE_BUTTON:
            self.secondNumber = [NSNumber numberWithDouble:[self.numberString doubleValue]];
            result = [self.doTheMath firstNumber:self.firstNumber sign:currentSign secondNumber:self.secondNumber];
            self.numberString = [NSString stringWithFormat:@"%f", result];
            self.output.text = self.numberString;
            self.backupResult = [NSNumber numberWithDouble:result];
            
            self.firstNumber = @0;
            self.secondNumber = @0;
            lastButtonPressed = EQUAL_BUTTON;
            break;
            
        case EQUAL_BUTTON:
            self.firstNumber = [NSNumber numberWithDouble:result];
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

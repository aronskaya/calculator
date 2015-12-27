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
    self.output.text = 0;
    self.numberString = [[NSString alloc]init];
    
    self.firstNumber = [[NSNumber alloc]init];
    self.secondNumber = [[NSNumber alloc]init];
    
    self.doTheMath = [[DoTheMath alloc]init];
    self.result = @"0";
        
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
    [self appendingFigure:@"0"];

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
    [self appendingFigure:@"."];
}


- (IBAction)plusSign:(id)sender {
    self.firstNumber = [self convertedString:self.numberString];
    self.numberString = @"";
    currentSign = PLUS;
    
}

- (IBAction)minusSign:(id)sender {
    self.firstNumber = [self convertedString:self.numberString];
    currentSign = MINUS;
    self.numberString = @"";

}

- (IBAction)divisionSign:(id)sender {
    self.firstNumber = [self convertedString:self.numberString];
    currentSign = DIVIDE;
    self.numberString = @"";

}

- (IBAction)multiplySign:(id)sender {
    self.firstNumber = [self convertedString:self.numberString];
    currentSign = MULTIPLY;
    self.numberString = @"";
}

- (IBAction)ACButton:(id)sender {
    self.firstNumber = @0;
    self.secondNumber = @0;
    currentSign = PLUS;
    self.numberString = @"";
    
}

- (IBAction)changeSignButton:(id)sender {
   // self.numberString = [NSString stringWithFormat:@"-%@", self.numberString];
    
}




- (IBAction)percentButton:(id)sender {
}

- (IBAction)equalSign:(id)sender {
    self.secondNumber = [NSNumber numberWithDouble:[self.numberString doubleValue]];
    double res = [self.doTheMath firstNumber:self.firstNumber sign:(currentSign) secondNumber:self.secondNumber];
    
    self.output.text = [NSString stringWithFormat:@"%f", res];
    
    self.firstNumber = self.secondNumber;
    self.secondNumber = @0;
    
}
@end

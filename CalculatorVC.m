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

- (IBAction)equalSign:(id)sender {

}

- (IBAction)plusSign:(id)sender {
    NSNumber * currentNumber = [NSNumber numberWithDouble:[self.numberString doubleValue]];
    

}

- (IBAction)minusSign:(id)sender {

}

- (IBAction)divisionSign:(id)sender {

}

- (IBAction)plus:(id)sender {
}
@end

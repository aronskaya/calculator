//
//  CalculatorVC.h
//  Calculator
//
//  Created by Julia Vashchenko on 12/25/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoTheMath.h"


@interface CalculatorVC : UIViewController {
    TheSign currentSign;
}

@property (weak, nonatomic) IBOutlet UILabel *output;
@property (strong, nonatomic) id result;
@property (strong, nonatomic) NSString *numberString;

@property (strong,nonatomic) NSNumber *firstNumber;
@property (strong,nonatomic) NSNumber *secondNumber;

@property (strong, nonatomic) DoTheMath *doTheMath;


- (IBAction)zeroButton:(id)sender;
- (IBAction)oneButton:(id)sender;
- (IBAction)twoButton:(id)sender;
- (IBAction)threeButton:(id)sender;
- (IBAction)fourButton:(id)sender;
- (IBAction)fiveButton:(id)sender;
- (IBAction)sixButton:(id)sender;
- (IBAction)sevenButton:(id)sender;
- (IBAction)eightButton:(id)sender;
- (IBAction)nineButton:(id)sender;

- (IBAction)commaButton:(id)sender;

- (IBAction)equalSign:(id)sender;
- (IBAction)plusSign:(id)sender;
- (IBAction)minusSign:(id)sender;
- (IBAction)divisionSign:(id)sender;
- (IBAction)multiplySign:(id)sender;


- (IBAction)ACButton:(id)sender;
- (IBAction)changeSignButton:(id)sender;
- (IBAction)percentButton:(id)sender;


@end


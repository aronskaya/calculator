//
//  CalculatorVC.h
//  Calculator
//
//  Created by Julia Vashchenko on 12/25/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoTheMath.h"

typedef NS_ENUM(NSInteger, LastButtonPressed) {
    EQUAL_BUTTON,
    PLUS_BUTTON,
    MINUS_BUTTON,
    MULTIPLY_BUTTON,
    DIVIDE_BUTTON,
    PERCENT_BUTTON,
    
    CHANGE_BUTTON,
    
    FIGURE_BUTTON,
    
    OPEN_APP_BUTTON,
};


@interface CalculatorVC : UIViewController {
    TheSign currentSign;
    LastButtonPressed lastButtonPressed;
    double result;

}

@property (weak, nonatomic) IBOutlet UILabel *output;
@property (strong, nonatomic) NSString *numberString;

@property (strong,nonatomic) NSNumber *firstNumber;
@property (strong,nonatomic) NSNumber *secondNumber;
@property (strong, nonatomic) NSNumber *backupSecondNumber;
@property (strong, nonatomic) NSNumber *backupResult;

@property (strong, nonatomic) DoTheMath *doTheMath;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) NSNumberFormatter *bigNumberFormatter;


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

@property (weak, nonatomic) IBOutlet UIButton *buttonACOutlet;



-(void)freshStartWithSign:(TheSign)sign andButton:(LastButtonPressed)button;

-(NSNumberFormatter *)numberFormatterForCurrentBackupResult;

//-(void)resultCalculationsForFirstNumber:(NSNumber *)firstNumber secondNumber:(NSNumber *)secondNumber;



@end


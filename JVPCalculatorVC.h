//
//  CalculatorVC.h
//  Calculator
//
//  Created by Julia Vashchenko on 12/25/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVPDoTheMath.h"

typedef NS_ENUM(NSInteger, LastButtonPressed) {
    kJVPOpenAppButton,
    kJVPEqualButton,
    kJVPPlusButton,
    kJVPMinusButton,
    kJVPMultiplyButton,
    kJVPDivideButton,
    kJVPPercentButton,
    kJVPChangeButton,
    kJVPFigureButton,
};

@interface JVPCalculatorVC : UIViewController {
    TheSign currentSign;
    LastButtonPressed lastButtonPressed;
}

@property (weak, nonatomic) IBOutlet UILabel *output;
@property (strong, nonatomic) NSString *numberString;

@property (strong,nonatomic) NSDecimalNumber *firstNumber;
@property (strong,nonatomic) NSDecimalNumber *secondNumber;
@property (strong, nonatomic) NSDecimalNumber *backupSecondNumber;
@property (strong, nonatomic) NSDecimalNumber *backupResult;
@property (strong, nonatomic) NSDecimalNumber *result;

@property (strong, nonatomic) JVPDoTheMath *doTheMath;
@property (strong, nonatomic) NSNumberFormatter *regularNumberFormatter;
@property (strong, nonatomic) NSNumberFormatter *smallBigNumberFormatter;

@property (strong, nonatomic) NSDecimalNumber *zero;


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

-(NSString *)stringForCurrentBackupResult;
-(NSDecimalNumber *)numberFromString:(NSString *)receivedNumberString;
-(void)calculateContunuously;
-(void)firstNumberSet;

@end


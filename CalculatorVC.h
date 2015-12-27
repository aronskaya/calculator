//
//  CalculatorVC.h
//  Calculator
//
//  Created by Julia Vashchenko on 12/25/15.
//  Copyright © 2015 Julia Vashchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *output;
@property (strong, nonatomic) id result;
@property (strong, nonatomic) NSString *numberString;

typedef NS_ENUM(NSInteger, TheSign) {
    PLUS,
    MINUS,
    DIVIDE,
    MULTIPLY,
    PERCENT
};



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














@end

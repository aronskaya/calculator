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
    
    //configuring an NSNumberFormatter for output of most numbers
    regularNumberFormatter = [[NSNumberFormatter alloc] init];
    regularNumberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    regularNumberFormatter.usesGroupingSeparator = YES;
    regularNumberFormatter.groupingSeparator = @" ";
    regularNumberFormatter.decimalSeparator = @".";
    regularNumberFormatter.maximumFractionDigits = 15;
    regularNumberFormatter.minimumFractionDigits = 0;
    
    //configuring an NSNumberFormatter for output of long numbers
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions Section

/**
 Returns a string, made of current backupResult
 */
-(NSString *)stringForCurrentBackupResult {
    //checking for division on zero and other mathematical errors
    if ([backupResult compare:[NSDecimalNumber notANumber]] == NSOrderedSame) {
        return @"Error";
    }
    
    //specifying conditions when regular or scientific style format of output is used
    NSNumberFormatter *selectedNumberFormatter;
    NSDecimalNumber *smallNumber = [NSDecimalNumber decimalNumberWithString:@"0.0000000000001"];
    NSDecimalNumber *bigNumber = [NSDecimalNumber decimalNumberWithString:@"999999999999999"];
    
    //configuring a temporary local formatter to make a string (checkString) so we could see if the number is too long for standard output
    NSNumberFormatter *tempNumberFormatter = [[NSNumberFormatter alloc]init];
    tempNumberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    tempNumberFormatter.usesGroupingSeparator = NO;
    tempNumberFormatter.decimalSeparator = @".";
    tempNumberFormatter.maximumFractionDigits = 15;
    tempNumberFormatter.minimumFractionDigits = 0;
    NSString *checkString = [tempNumberFormatter stringFromNumber:backupResult];
    
    
    //getting absolute value of a number
    NSDecimal decimalStruct = backupResult.decimalValue;
    unsigned int isPositive = 0;
    decimalStruct._isNegative = isPositive;
    NSDecimalNumber *positiveNumber = [NSDecimalNumber decimalNumberWithDecimal:decimalStruct];
    
    
    //choosing the appropriate formatter
    
    if (([positiveNumber compare:zero] == NSOrderedDescending) && (([positiveNumber compare:bigNumber] == NSOrderedDescending) || ([positiveNumber compare:bigNumber] == NSOrderedSame) || ([positiveNumber compare:smallNumber] == NSOrderedAscending) || ([positiveNumber compare:smallNumber] == NSOrderedSame))) {
        
        selectedNumberFormatter = smallBigNumberFormatter;
    }
    

    else
        selectedNumberFormatter = regularNumberFormatter;
    
        //checking if the number isn't too long. If it is, round it off
        if (checkString.length >= 15)
        {
            NSRange rangeOfPoint = [checkString rangeOfString:@"."];
            short symbolsToRoundOff = checkString.length - 15 + 1;
            short symbolsAfterPoint = checkString.length - rangeOfPoint.location - 1;
            short symbolsAfterPointToLeave = symbolsAfterPoint - symbolsToRoundOff;
            
            NSDecimalNumberHandler *roundOffHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:symbolsAfterPointToLeave raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
            backupResult = [backupResult decimalNumberByRoundingAccordingToBehavior:roundOffHandler];
            
        }
    
    //generating string
    NSString *resultString = [selectedNumberFormatter stringFromNumber:backupResult];
    return resultString;
}

/**
 Makes basic calculations for cases like 10 + 3 - 1 + 5... (continuous calculations not involving equal button)
 */
-(void)calculateContunuously {
    secondNumber = [self numberFromString:numberString];
    result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
    backupResult = result;
    numberString = [self stringForCurrentBackupResult];
    output.text = numberString;
    firstNumber = backupResult;
    numberString = @"";
}

-(void)firstNumberSet {
    firstNumber = [self numberFromString:numberString];
    numberString = @"";
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}
*/


/**
 Adds a figure to the end of the numberString when appropriate button is pressed
 */
-(NSString *)appendingFigure:(NSString *)figureString {
    if ([numberString isEqualToString:@"0"] || (lastButtonPressed == kJVPEqualButton)) {
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

- (IBAction)infoButtonPressed:(id)sender {
    
    //telling the compiler that sender is in fact a UIButton,
    //sender.frame wouldn't work
    
    UIButton *button = (UIButton *)sender;
    
    // grab the view controller we want to show
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Pop"];
    
    // present the controller
    // on iPad, this will be a Popover
    // on iPhone, this will be an action sheet
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    // configure the Popover presentation controller
    UIPopoverPresentationController *popController = [controller popoverPresentationController];

    popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popController.delegate = self;
    
    // setting the position of the arrow similar to the position of the infoButton
    popController.sourceView = self.view;
    popController.sourceRect = button.frame;


}

-(void)freshStartWithSign:(TheSign)sign andButton:(LastButtonPressed)button {
    firstNumber = backupResult;
    numberString = @"";
    currentSign = sign;
    lastButtonPressed = button;
}

#pragma mark - Figure and Comma Buttons Section

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
    if (([numberString isEqualToString:@""]) || ([numberString isEqualToString:@"0"]) || (lastButtonPressed == kJVPPlusButton) || (lastButtonPressed == kJVPMinusButton) || (lastButtonPressed == kJVPDivideButton) || (lastButtonPressed == kJVPMultiplyButton) || (lastButtonPressed == kJVPEqualButton)) {
        numberString = @"0.";
        output.text = numberString;
    }
    
    if (![numberString containsString:@"."]) {
        [self appendingFigure:@"."];
    }
}

#pragma mark - Signs Buttons Section

- (IBAction)plusSign:(id)sender {
    switch (lastButtonPressed) {
        case kJVPFigureButton:
        case kJVPChangeButton:
            
            //standard calculations, e.g. 10 + 3 = ...
            if ([firstNumber compare:zero] == NSOrderedSame) {
                [self firstNumberSet];
            }
            
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                [self calculateContunuously];
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
                [self firstNumberSet];
            }
                        //continuous calculations, e.g. 10 + 3 + 5...
            else {
                [self calculateContunuously];
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
                [self firstNumberSet];
            }
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                [self calculateContunuously];
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
                [self firstNumberSet];
            }
            //continuous calculations, e.g. 10 + 3 + 5...
            else {
                [self calculateContunuously];
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

#pragma mark - AC, Change Sign, Percent and Equals Buttons Section

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

- (IBAction)percentButton:(id)sender {
    currentSign = kJVPPercentSign;
    
    switch (lastButtonPressed) {
        case kJVPFigureButton:
        case kJVPChangeButton:
            
            if ([firstNumber compare:zero] == NSOrderedSame) {
                firstNumber = [self numberFromString:numberString];
                secondNumber = zero;
                result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
                backupResult = result;
                numberString = [self stringForCurrentBackupResult];
                output.text = numberString;
                numberString = @"";
                firstNumber = zero;
            }
            else {
                [self calculateContunuously];
                firstNumber = zero;
            }
            break;
        case kJVPPercentButton:
        case kJVPEqualButton:
            firstNumber = backupResult;
            secondNumber = zero;
            result = [self.doTheMath firstNumber:firstNumber sign:currentSign secondNumber:secondNumber];
            backupResult = result;
            numberString = [self stringForCurrentBackupResult];
            output.text = numberString;
            numberString = @"";
            firstNumber = zero;
            break;

        case kJVPPlusButton:
        case kJVPMinusButton:
        case kJVPDivideButton:
        case kJVPMultiplyButton:
            break;
        case kJVPOpenAppButton:
            [self freshStartWithSign:kJVPPercentSign andButton:kJVPPercentButton];
            break;
    }
    lastButtonPressed = kJVPPercentButton;
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

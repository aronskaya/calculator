//
//  JVPPopoverVC.h
//  CalculatorFree
//
//  Created by Julia Vashchenko on 1/9/16.
//  Copyright © 2016 Julia Vashchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JVPPopoverContentVCDelegate <NSObject>
-(void)jVPPopoverContentVCDidClose;
@end


@interface JVPPopoverContentVC : UIViewController
@property (nonatomic, weak) id <JVPPopoverContentVCDelegate> delegate;

- (IBAction)closeButtonPressed:(id)sender;

@end






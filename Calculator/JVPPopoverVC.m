//
//  JVPPopoverVC.m
//  CalculatorFree
//
//  Created by Julia Vashchenko on 1/9/16.
//  Copyright © 2016 Julia Vashchenko. All rights reserved.
//

#import "JVPPopoverVC.h"

@interface JVPPopoverVC ()

@end

@implementation JVPPopoverVC

- (void)viewWillAppear:(BOOL)animated {
    CGFloat width = 300;
    CGFloat height = 250;
    self.preferredContentSize = CGSizeMake(width, height);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    // Do any additional setup after loading the view.
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

@end

//
//  SplashController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/13/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "SplashController.h"

@interface SplashController ()

@end

@implementation SplashController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLoadingLabel];
    [self performSelector:@selector(changeController) withObject:nil afterDelay:1];
    //[self animate];
}
-(void)changeController {
    
    [appDelegate setRootLoginController];
}

- (void) updateLoadingLabel;
{
    if(lblLoading) {
        if([lblLoading.text isEqualToString:@"Loading...."]) {
            lblLoading.text = @"Loading";
        } else {
            lblLoading.text = [NSString stringWithFormat:@"%@.",lblLoading.text];
        }
        [self performSelector:@selector(updateLoadingLabel) withObject:nil afterDelay:0.5]; //each second
    }
    
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

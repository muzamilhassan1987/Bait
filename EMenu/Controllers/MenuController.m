//
//  MenuController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/12/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "MenuController.h"
#import "CategoryController.h"
@interface MenuController ()

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)enterEnglish {
    
    singleton.isEnglish = YES;
//    [appDelegate setRootLoginController];
    [self gotoCategory];
}
-(IBAction)enterArabic {
    
    singleton.isEnglish = NO;
//    [appDelegate setRootLoginController];
    [self gotoCategory];
}
-(void)gotoCategory {
    
    CategoryController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryController"];
    [self.navigationController pushViewController:controller animated:YES];
    
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

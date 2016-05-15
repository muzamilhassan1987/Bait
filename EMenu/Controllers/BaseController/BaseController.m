//
//  BaseController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/12/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadImageFromUrl:(NSString*)strLink ImageView:(UIImageView*)imgV{
    
    __weak UIImageView* imgView = imgV;
    
    [imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strLink]]
                   placeholderImage:nil
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                
                                [UIView transitionWithView:imgView
                                                  duration:0.2
                                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                                animations:^{
                                                    imgView.image = image;
                                                    
                                                }
                                                completion:NULL];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                
                            }];
    
}

-(IBAction)singlePopViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc {
    
    appDelegate = nil;
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

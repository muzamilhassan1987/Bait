//
//  AppDelegate.h
//  EMenu
//
//  Created by Soomro Shahid on 7/9/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)setRootMenuController;
-(void)setRootLoginController;
-(void)setRootCategoryController;

@end


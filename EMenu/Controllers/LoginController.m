//
//  LoginController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/16/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "LoginController.h"
#import "OrderDetailController.h"
@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [SERVICE_MODEL updateCategory:<#(NSMutableDictionary *)#> completionBlock:^(NSObject *response) {
//        <#code#>
//    } failureBlock:^(NSError *error) {
//        <#code#>
//    }];
    
    // Do any additional setup after loading the view.
}
-(IBAction)login {
    
//     [self callDataFromServer];
//    return;
    
//    [txtEmail setText:@"hardees@baitwared.com"];
//    [txtTableID setText:@"10"];
    
    
   // [txtEmail setText:@"test@bait.com"];
    //[txtTableID setText:@"1"];
    NSLog(@"%@",txtTableID.text);
    [self.view endEditing:YES];
    if (![Validation ValidateStringLength:txtEmail.text]) {
        SIMPLE_ALERT(@"Alert", @"Enter Email")
        return;
    }
    if (![Validation ValidateEmail:txtEmail.text]) {
        SIMPLE_ALERT(@"Alert", @"Enter Valid Email")
        return;
    }
    if (![Validation ValidateStringLength:txtTableID.text]) {
        SIMPLE_ALERT(@"Alert", @"Enter Table No")
        return;
    }
    [self callDataFromServer];
    
}
-(void)callDataFromServer {
    
   // loginCustomer/email:hardees@baitwared.com/table_number:1
    //http://albatilahtwigs.com/restaurant/loginCustomer/email:hardees@baitwared.com/table_number:1
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:txtEmail.text forKey:@"email"];
    [parameters setValue:txtTableID.text forKey:@"table_number"];
    
    
    [SERVICE_MODEL loginUser:parameters completionBlock:^(NSObject *response) {
        
        
        singleton.loginDetail = [TableBaseClass modelObjectWithDictionary:(NSDictionary *)response];
        [appDelegate setRootCategoryController];
        
    } failureBlock:^(NSError *error) {
        
    }];
    
  //  [appDelegate setRootCategoryController];
    
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength >30) ? NO : YES;
    
    
    //    if(newLength <= 30) {
    //        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    //
    //        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    //
    //        return [string isEqualToString:filtered];
    //    }
    //    else {
    //        return (newLength >30) ? NO : YES;
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


//
//  SendingOrderController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/27/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "SendingOrderController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"
@interface SendingOrderController ()

@end

@implementation SendingOrderController
@synthesize strTotalAmount;
- (void)viewDidLoad {
    [super viewDidLoad];
    [lblTableNo setText:[NSString stringWithFormat:@"Table no %@",singleton.loginDetail.result.tableNumber]];
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    isOrderSend = NO;
    [self runAnimaiton];
    [self sendDataToServer];
}
-(void)sendDataToServer {
    
    [btnMenu setUserInteractionEnabled:NO];
    /*
     
     table_id , restaurant_id, order_amount , order (JSON STRING)
     JSON STRING EXAMPLE :  {"order":[{"item_id":2,"item_quantity":2,"item_price":30},{"item_id":1,"item_quantity":2,"item_price"
     
     */
    //{"order":[{"item_id":2,"item_quantity":2,"item_price":30},{"item_id":1,"item_quantity":2,"item_price":20}]}
    for (int i=0;i<singleton.arrOrderItems.count;i++){
        
        NSMutableDictionary* dic = [singleton.arrOrderItems objectAtIndex:i];
        [dic removeObjectForKey:@"item_name"];
        [dic removeObjectForKey:@"totalPrice"];
        
    }
    
    
    
//    NSMutableArray* testarray = [NSMutableArray array];
//    NSMutableDictionary* testDic = [NSMutableDictionary dictionary];
//    [testDic setValue:@"6" forKey:@"item_id"];
//    [testDic setValue:@"11" forKey:@"item_price"];
//    [testDic setValue:@"3" forKey:@"item_quantity"];
//    
//    [testarray addObject:testDic];
    
    
   // NSLog(@"%@",strTotalAmount);
    NSError* error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:testarray options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//   // NSLog(@"%@",jsonString);
//    
//    NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//    
//   // NSLog(@"%@",json);
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    NSMutableDictionary* arrayorder = [NSMutableDictionary dictionary];
    [arrayorder setValue:singleton.arrOrderItems forKey:@"order"];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrayorder options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [parameters setValue:singleton.loginDetail.result.tableId forKey:@"table_id"];
    [parameters setValue:singleton.loginDetail.result.restaurantId forKey:@"restaurant_id"];
    [parameters setValue:strTotalAmount forKey:@"order_amount"];
    [parameters setValue:jsonString forKey:@"order"];

//    [parameters setValue:@"12" forKey:@"table_id"];
//    [parameters setValue:@"3" forKey:@"restaurant_id"];
//    [parameters setValue:@"100" forKey:@"order_amount"];
//    [parameters setValue:jsonString forKey:@"order"];


    NSLog(@"%@",parameters);
    [SERVICE_MODEL addOrder:parameters completionBlock:^(NSObject *response) {
        
        [btnMenu setUserInteractionEnabled:YES];
        SIMPLE_ALERT(@"Alert", [response valueForKey:@"Message"])
        if ([[response valueForKey:@"Response"] isEqualToString:@"Success"]) {
        
        }

        
    } failureBlock:^(NSError *error) {
        [btnMenu setUserInteractionEnabled:YES];
    }];
}
-(IBAction)gotoCategoryScreen{
    
    
    
    //[singleton.arrOrderItems removeAllObjects];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
//    rotationAnimation.duration = duration3
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = repeat;
//    
//    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
}
-(void)runAnimaiton {
    CABasicAnimation *rotate;
    rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:0];
    rotate.toValue = [NSNumber numberWithFloat:degreesToRadians(360)];
    rotate.duration = 2.0;
    rotate.repeatCount = 1;
    [imgSending.layer addAnimation:rotate forKey:@"10"];
    [self performSelector:@selector(runAnimaiton) withObject:nil afterDelay:2.0];
}
#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    o
//}


@end

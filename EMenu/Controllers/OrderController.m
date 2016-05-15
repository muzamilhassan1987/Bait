//
//  OrderController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/13/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "OrderController.h"
#import "OrderDetailController.h"
#import "MMPickerView.h"
@interface OrderController ()

@end

@implementation OrderController
@synthesize dicData;
- (void)viewDidLoad {
    [super viewDidLoad];

    
    if ([[dicData valueForKey:@"categoryId"] integerValue] != 16) {
        [btnLeft setHidden:YES];
        [btnRight setHidden:YES];
    }
    
    currentItemNumber = 0;
    //arrOrderItems = [NSMutableArray array];
    [imgVLoading setHidden:YES];
    arrQuantities = [NSMutableArray array];
    for (int i=1;i<=100;i++) {
        
        [arrQuantities addObject:[NSString stringWithFormat:@"%d",i]];
    }
    selectedString = [arrQuantities objectAtIndex:0];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [self filterArray];
    //[self getDataFromServer];
}

-(void)filterArray {
    

//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Name CONTAINS[cd] %@",[dicData valueForKey:@"categoryId"]];
    
    BOOL isSearch = [[dicData valueForKey:@"isSearch"] boolValue];
    if(isSearch){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"categoryId == %@",[dicData valueForKey:@"categoryId"]];
        NSArray *filtered  = [singleton.allMenuItems.result.items filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@",singleton.allMenuItems.result.items);
        NSLog(@"%@",filtered);
        arrItemsList = [filtered mutableCopy];
        
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"itemId == %@",[dicData valueForKey:@"itemId"]];
        NSArray *filtered1  = [arrItemsList filteredArrayUsingPredicate:predicate1];
        NSInteger i = [arrItemsList indexOfObject:[filtered1 objectAtIndex:0]];
        currentItemNumber = i;
        NSLog(@"%ld",i);
        
        [imgVLoading setHidden:NO];
        [self runAnimaiton];
        [self loadCurrentItem];
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"categoryId == %@",[dicData valueForKey:@"categoryId"]];
        NSArray *filtered  = [singleton.allMenuItems.result.items filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@",singleton.allMenuItems.result.items);
        NSLog(@"%@",filtered);
        
        if(filtered.count <= 0) {
            [self.navigationController popViewControllerAnimated:YES];
            SIMPLE_ALERT(@"Alert", @"There is no item in the selected category")
            return;
        }
        
        arrItemsList = [filtered mutableCopy];
        [imgVLoading setHidden:NO];
        [self runAnimaiton];
        [self loadCurrentItem];
    }
    

   // [arrSearched removeAllObjects];
    //arrSearched = nil;
    //arrSearched = [filtered mutableCopy];
    //[collectionList reloadData];
    //if (![Validation ValidateStringLength:txtSearch.text]) {
     //   arrSearched = [arrData mutableCopy];
    //}

    
}
-(void)getDataFromServer {
    
    
//    http://www.albatilahtwigs.com/Menus/getItems/categoryId:3/restaurantId:2
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:singleton.loginDetail.result.restaurantId forKey:@"restaurantId"];
    [parameters setValue:[dicData valueForKey:@"categoryId"] forKey:@"categoryId"];
    NSLog(@"%@",singleton.arrOrderItems);
    NSLog(@"%@",singleton.arrOrderItems);
    
    arrOrderItems = nil;
    arrOrderItems = [singleton.arrOrderItems mutableCopy];
    
    [SERVICE_MODEL getSelectedCategoryItems:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@",singleton.arrOrderItems);
        [self updateArray];
       // arrData = [[response valueForKey:@"Result"] valueForKey:@"Items"];
        menuDetail = [MenuBaseClass modelObjectWithDictionary:(NSDictionary *)response];
        if (menuDetail.result.items.count > 0){
            [imgVLoading setHidden:NO];
            [self runAnimaiton];
            [self loadCurrentItem];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
            SIMPLE_ALERT(@"Alert", @"There is no item in the selected category")
        }
        
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}
-(void)updateArray {
    
    singleton.arrOrderItems = [arrOrderItems mutableCopy];
    [arrOrderItems removeAllObjects];
    NSLog(@"%@",singleton.arrOrderItems);
    arrOrderItems = nil;
}
-(void)loadCurrentItem {
    
    MenuItems* selectedItem = [arrItemsList objectAtIndex:currentItemNumber];
    //MenuItems* selectedItem = [menuDetail.result.items objectAtIndex:currentItemNumber];
    
    [imgVItem setImage:[UIImage imageNamed:@""]];
    
    
//    [self loadImageFromUrl:selectedItem.itemImage ImageView:imgVItem];
    [lblName setText:selectedItem.itemTitle];
    [lblPrice setText:[NSString stringWithFormat:@"%@ SAR",selectedItem.itemPrice]];
    [lblDescription setText:selectedItem.itemDetail];
    //    [txtAmount setText:@""];
    [btnQuantity setTitle:@"0" forState:UIControlStateNormal];
    // [lblItemNumber setText:[NSString stringWithFormat:@"%ld/%.0f",(long)currentItemNumber+1,menuDetail.result.totalRecords]];
    [lblItemNumber setText:[NSString stringWithFormat:@"%ld/%ld",(long)currentItemNumber+1,arrItemsList.count]];
    
    
    
    [self loadImageFromUrl:selectedItem.itemImage ImageView:imgVItem];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:selectedItem.itemImage] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0f];
//    UIImage *image = [[UIImageView sharedImageCache] cachedImageForRequest:urlRequest];
//    if (image != nil) {
//        return;
//    }
//    else {
//        AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
//        postOperation.responseSerializer = [AFImageResponseSerializer serializer];
//        [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            UIImage *image = responseObject;
//            [[UIImageView sharedImageCache] cacheImage:image forRequest:urlRequest];
//            [imgVItem setImage:image];
//            //[self loadImageFromUrl:selectedItem.itemImage ImageView:imgVItem];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Image error: %@", error);
//        }];
//        [postOperation start];
//    }
    
    
    
}
-(IBAction)leftPressed {
    
    [self.view endEditing:YES];
    if(currentItemNumber > 0) {
        currentItemNumber--;
        [self loadCurrentItem];
    }
//    NSMutableDictionary* data = [arrData objectAtIndex:0];
//    [lblPrice setText:[data valueForKey:@"item_price"]];
//    [self loadImageFromUrl:[data valueForKey:@"item_image"] ImageView:imgVItem];
    
}
-(IBAction)rightPressed {
    
    [self.view endEditing:YES];
//    if(currentItemNumber < menuDetail.result.totalRecords-1) {
    if(currentItemNumber < arrItemsList.count-1) {

        currentItemNumber++;
        [self loadCurrentItem];
    }
}

-(IBAction)addOrder {
    
    NSInteger orderCount = [btnQuantity.titleLabel.text integerValue];
    
    [self.view endEditing:YES];
//    if (![Validation ValidateStringLength:txtAmount.text]){
//        SIMPLE_ALERT(@"Alert", @"Enter Quantity")
//        return;
//    }
//    if ([txtAmount.text integerValue] <= 0){
//        SIMPLE_ALERT(@"Alert", @"Quantity Must Be Greater Than 0")
//        return;
//    }

    if (orderCount <= 0){
        SIMPLE_ALERT(@"Alert", @"Select Quantity")
        return;
    }
//    if ([txtAmount.text integerValue] <= 0){
//        SIMPLE_ALERT(@"Alert", @"Quantity Must Be Greater Than 0")
//        return;
//    }
    
//    MenuItems* selectedItem = [menuDetail.result.items objectAtIndex:currentItemNumber];
    MenuItems* selectedItem = [arrItemsList objectAtIndex:currentItemNumber];
    if ([ singleton.arrOrderItems count]>0) {
        //NSString *str = selectedItem.itemId;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"item_id == %@",selectedItem.itemId];
        NSArray *filtered  = [singleton.arrOrderItems filteredArrayUsingPredicate:predicate];
        if(filtered.count>0){
            NSInteger index = [singleton.arrOrderItems indexOfObject:filtered[0]];
            NSLog(@"%ld",(long)index);
            [singleton.arrOrderItems removeObjectAtIndex:index];
        }
    }
    
//    NSInteger totalPrice = [txtAmount.text integerValue]* [selectedItem.itemPrice integerValue];
    
    NSInteger totalPrice = orderCount * [selectedItem.itemPrice integerValue];
    
    NSMutableDictionary* dicOrder = [NSMutableDictionary dictionary];
    [dicOrder setValue:selectedItem.itemId forKey:@"item_id"];
    [dicOrder setValue:selectedItem.itemTitle forKey:@"item_name"];
    [dicOrder setValue:btnQuantity.titleLabel.text forKey:@"item_quantity"];
    [dicOrder setValue:selectedItem.itemPrice forKey:@"item_price"];
    [dicOrder setValue:[NSString stringWithFormat:@"%ld",(long)totalPrice] forKey:@"totalPrice"];
    
    [singleton.arrOrderItems addObject:dicOrder];
    SIMPLE_ALERT(@"Alert", @"Order Added In The List")
//    [txtAmount setText:@""];
    [btnQuantity setTitle:@"0" forState:UIControlStateNormal];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField.text length]>0) {
        if ([textField.text integerValue]>0) {
           // itemQuantity = textField.text;
           // [self addOrder];
        }
        
    }
    
//{"order":[{"item_id":2,"item_quantity":2,"item_price":30},{"item_id":1,"item_quantity":2,"item_price":20}]}
    NSLog(@"textFieldShouldEndEditing");
    
    //No hay errores de validación
    return YES;    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    //return (newLength >60) ? NO : YES;
    
    
    if(newLength <= 3) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_NUMBERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    else {
        return (newLength >3) ? NO : YES;
    }
}

-(IBAction)confirmOrder {
 
    if ([singleton.arrOrderItems count] <= 0){
        SIMPLE_ALERT(@"Alert", @"Select Orders")
        return;
    }
    
//    for (int test=0; test<10; test++) {
//        [singleton.arrOrderItems addObject:[singleton.arrOrderItems objectAtIndex:0]];
//    }
    OrderDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderDetailController"];
    controller.arrData = [singleton.arrOrderItems mutableCopy];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)runAnimaiton {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    CABasicAnimation *rotate;
    rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:0];
    rotate.toValue = [NSNumber numberWithFloat:degreesToRadians(360)];
    rotate.duration = 2.0;
    rotate.repeatCount = 1;
    [imgVLoading.layer addAnimation:rotate forKey:@"10"];
    [self performSelector:@selector(runAnimaiton) withObject:nil afterDelay:2.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc {
    
    if (dicData){
        [dicData removeAllObjects];
        dicData = nil;
    }
    menuDetail = nil;
    if (arrItemsList) {
        [arrItemsList removeAllObjects];
        arrItemsList = nil;
    }
    if (arrOrderItems) {
        [arrOrderItems removeAllObjects];
        arrOrderItems = nil;
    }
}

-(IBAction)selectQuantity {

    [MMPickerView showPickerViewInView:self.view
                           withStrings:arrQuantities
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString1) {
                                
                                
                                NSLog(@"%@",selectedString1);
                                if ([selectedString1 integerValue] > 0) {
                                    [btnQuantity setTitle:selectedString1 forState:UIControlStateNormal];
                                }
                                selectedString = selectedString1;
                                NSLog(@"%@",selectedString1);
                               // _label.text = selectedString;
                              //  _selectedString = selectedString;
                            }];
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

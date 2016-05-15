//
//  OrderDetailController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/13/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "OrderDetailController.h"
#import <objc/runtime.h>
#import "SendingOrderController.h"
#import "MMPickerView.h"
@interface OrderDetailController ()

@end

@implementation OrderDetailController
static char selectedBtn,selectedLbl;
@synthesize arrData;
- (void)viewDidLoad {
    [super viewDidLoad];
   // NSLog(@"%@",singleton.loginDetail.result.tableNumber);
    
    [tblList setBackgroundColor:[UIColor clearColor]];
    [tblList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblList setDelaysContentTouches:NO];
    [lblTblNumber setText:[NSString stringWithFormat:@"Table No %@",singleton.loginDetail.result.tableNumber]];
    
    arrQuantities = [NSMutableArray array];
    for (int i=1;i<=100;i++) {
        
        [arrQuantities addObject:[NSString stringWithFormat:@"%d",i]];
    }
    selectedString = [arrQuantities objectAtIndex:0];
    
    
    iTotalAmount = 0;
    for (int i=0; i<singleton.arrOrderItems.count; i++) {
        NSMutableDictionary* dic = [singleton.arrOrderItems objectAtIndex:i];
        iTotalAmount = [[dic valueForKey:@"totalPrice"]integerValue] + iTotalAmount;
    }
    NSLog(@"TOTAL AMOUT %ld",(long)iTotalAmount);
    [lblTotalAmount setText:[NSString stringWithFormat:@"%ld  SAR",(long)iTotalAmount]];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return arrData.count;
    return singleton.arrOrderItems.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    
    NSMutableDictionary* data = [singleton.arrOrderItems/*arrData*/ objectAtIndex:indexPath.row];
    
    [cell setExclusiveTouch:YES];
    [cell.contentView setExclusiveTouch:YES];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    }
    
    UILabel* lblName = (UILabel*)[cell viewWithTag:1];
    UILabel* lblQuantity = (UILabel*)[cell viewWithTag:200];
    [lblQuantity setHidden:YES];
    UIButton* btnQuantity = (UIButton*)[cell viewWithTag:2];
    UILabel* lblPrice = (UILabel*)[cell viewWithTag:3];
    UIButton* btnCross = (UIButton*)[cell viewWithTag:4];
    [lblName setText:[data valueForKey:@"item_name"]];
    //[lblQuantity setText:[data valueForKey:@"item_quantity"]];
    [btnQuantity setTitle:@"" forState:UIControlStateNormal];
    [btnQuantity setTitle:[data valueForKey:@"item_quantity"] forState:UIControlStateNormal];
    [lblPrice setText:[NSString stringWithFormat:@"%@ SAR",[data valueForKey:@"totalPrice"]]];
    
    [btnQuantity addTarget:self action:@selector(editQuantity:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(btnQuantity, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    
    
    [btnCross addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(btnCross, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(btnQuantity, &selectedLbl, lblPrice, OBJC_ASSOCIATION_RETAIN);
    
    
    return cell;
}
-(void)editQuantity:(id)sender {
    
    UIButton* btnQuantity = (UIButton*)sender;
    UILabel* lblPrice = (UILabel*)objc_getAssociatedObject(btnQuantity, &selectedLbl);
//    UIButton* btnQuantity = objc_getAssociatedObject(sender, &selectedBtn);
    NSInteger row = [objc_getAssociatedObject(btnQuantity, &selectedBtn) integerValue];
    
    NSMutableDictionary* data = [singleton.arrOrderItems/*arrData*/ objectAtIndex:row];
    
    NSLog(@"%@",data);
    
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
                                NSMutableDictionary* dic = data;
                                [dic setValue:selectedString1 forKey:@"item_quantity"];
                                NSInteger total = [selectedString1 integerValue]*[[dic valueForKey:@"item_price"] integerValue];
                                [dic setValue:[NSString stringWithFormat:@"%d",total] forKey:@"totalPrice"];
                                [lblPrice setText:[NSString stringWithFormat:@"%@ SAR",[dic valueForKey:@"totalPrice"]]];
                                NSLog(@"%@",selectedString1);
                                
                                iTotalAmount = 0;
                                for (int i=0; i<singleton.arrOrderItems.count; i++) {
                                    NSMutableDictionary* dic = [singleton.arrOrderItems objectAtIndex:i];
                                    iTotalAmount = [[dic valueForKey:@"totalPrice"]integerValue] + iTotalAmount;
                                }
                                NSLog(@"TOTAL AMOUT %ld",(long)iTotalAmount);
                                [lblTotalAmount setText:[NSString stringWithFormat:@"%ld  SAR",(long)iTotalAmount]];
                                
                            }];
    
}

-(void)deleteItem:(id)sender {
 
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure want to delete ?"
                                                        message:nil delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes",nil];
    [alertView show];
    objc_setAssociatedObject(alertView, &selectedBtn, sender, OBJC_ASSOCIATION_RETAIN);

    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%@",singleton.arrOrderItems);
    
    if(buttonIndex == 1) {
        UIButton* btnDelete = objc_getAssociatedObject(alertView, &selectedBtn);
        NSInteger row = [objc_getAssociatedObject(btnDelete, &selectedBtn) integerValue];
        
        NSMutableDictionary* dic = [singleton.arrOrderItems objectAtIndex:row];
        iTotalAmount = iTotalAmount - [[dic valueForKey:@"totalPrice"]integerValue] ;
        [lblTotalAmount setText:[NSString stringWithFormat:@"%ld SAR",(long)iTotalAmount]];
        
        [singleton.arrOrderItems removeObjectAtIndex:row];
        NSLog(@"ROW --  %ld",(long)row);
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [tblList beginUpdates];
        [tblList deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        [tblList endUpdates];
//        [singleton.arrOrderItems removeObjectAtIndex:row];
    }
    
}

-(IBAction)confirmOrder {
    
    if(singleton.arrOrderItems.count<=0){
     
        SIMPLE_ALERT(@"Alert", @"No items added")
        return;
    }
    
    SendingOrderController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"sendingOrderController"];
    [controller setStrTotalAmount:[NSString stringWithFormat:@"%ld",(long)iTotalAmount]];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    NSLog(@"viewWillDisappear");
    NSLog(@"%@",singleton.arrOrderItems);
}

-(void)deleteSelectedItem {
    
}
-(void)dealloc {
    if(arrData){
        [arrData removeAllObjects];
        arrData = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    NSLog(@"%@",[segue identifier]);
//    if ([[segue identifier] isEqualToString:@"ConfirmOrder"])
//    {
//        SendingOrderController *vc = [segue destinationViewController];
//        [vc setStrTotalAmount:[NSString stringWithFormat:@"%ld",iTotalAmount]];
//    }
//    
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


@end

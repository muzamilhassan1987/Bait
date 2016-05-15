//
//  OrderController.h
//  EMenu
//
//  Created by Soomro Shahid on 7/13/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface OrderController : BaseController
{
    __weak IBOutlet UIButton* btnLeft;
    __weak IBOutlet UIButton* btnRight;
    
    __weak IBOutlet UIImageView* imgVItem;
    __weak IBOutlet UIImageView* imgVLoading;
    __weak IBOutlet UILabel* lblPrice;
    __weak IBOutlet UILabel* lblName;
    __weak IBOutlet UILabel* lblDescription;
    __weak IBOutlet UILabel* lblItemNumber;
    __weak IBOutlet UITextField* txtAmount;
    __weak IBOutlet UIButton* btnQuantity;
    NSMutableArray* arrOrderItems;
    MenuBaseClass* menuDetail;
    NSMutableArray* arrItemsList;
    NSInteger currentItemNumber;
    NSString* itemQuantity;
    
    
    NSMutableArray* arrQuantities;
    NSString * selectedString;
    
}
@property(nonatomic,strong)NSMutableDictionary* dicData;
@end

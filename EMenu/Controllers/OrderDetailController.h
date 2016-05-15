//
//  OrderDetailController.h
//  EMenu
//
//  Created by Soomro Shahid on 7/13/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface OrderDetailController : BaseController {
    
    __weak IBOutlet UILabel* lblTblNumber;
    __weak IBOutlet UITableView* tblList;
    __weak IBOutlet UILabel* lblTotalAmount;
    NSInteger iTotalAmount;
    NSMutableArray* arrQuantities;
    NSString * selectedString;
}
@property(nonatomic,strong)NSMutableArray* arrData;
@end

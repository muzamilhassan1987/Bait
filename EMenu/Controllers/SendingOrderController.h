//
//  SendingOrderController.h
//  EMenu
//
//  Created by Soomro Shahid on 7/27/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface SendingOrderController : BaseController
{
    __weak IBOutlet UIImageView* imgSending;
    __weak IBOutlet UILabel* lblTableNo;
    __weak IBOutlet UIButton* btnMenu;
    BOOL isOrderSend;
}
@property(nonatomic,strong)NSString* strTotalAmount;
@end

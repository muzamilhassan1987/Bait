//
//  MenuListController.h
//  EMenu
//
//  Created by Soomro Shahid on 9/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface MenuListController : BaseController
{
     __weak IBOutlet UICollectionView* collectionList;
    NSMutableArray* arrItemsList;
    NSMutableArray* arrCategoryList;
    __weak IBOutlet UILabel* lblTitle;
}
@property(nonatomic,strong)NSMutableDictionary* dicData;

@end

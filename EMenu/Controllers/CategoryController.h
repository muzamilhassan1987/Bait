//
//  CategoryController.h
//  EMenu
//
//  Created by Soomro Shahid on 7/12/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"
#import "DropDownTableView.h"
#import "MLKMenuPopover.h"
@interface CategoryController : BaseController<MLKMenuPopoverDelegate>
{
    __weak IBOutlet UICollectionView* collectionList;
    
    DropDownTableView* autocompleteTableView;
    
    NSArray* arrMenuDropDown;
    MLKMenuPopover *menuPopover;
    
    NSMutableArray* arrData;
    NSMutableArray* arrSearched;
    __weak IBOutlet UITextField* txtSearch;
    __weak IBOutlet UILabel* lblCount;
    
    __weak IBOutlet UIButton* btnBreakfask;
    __weak IBOutlet UIButton* btnConfirmOrder;
    
    __weak IBOutlet UIImageView* imgSearchBg;
    
    BOOL isDataLoaded;
}
@end

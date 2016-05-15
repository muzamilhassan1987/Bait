//
//  DropDownTableView.h
//  EMenu
//
//  Created by Soomro Shahid on 8/9/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownTableView : UITableView <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray* pastUrls;
    NSMutableArray* autocompleteUrls;
}
-(void)initialize;
-(void)reloadtable ;
@end

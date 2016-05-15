//
//  MenuListController.m
//  EMenu
//
//  Created by Soomro Shahid on 9/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "MenuListController.h"
#import <objc/runtime.h>
#import "OrderController.h"
@interface MenuListController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation MenuListController
static char selectedBtn;
@synthesize dicData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrCategoryList = [NSMutableArray arrayWithObjects:
                       @"Salads",
                       @"Cold Mezze",
                       @"Hot Mezze",
                       @"Fatteh",
                       @"Nayyeh",
                       @"From the Oven",
                       @"Mashawi",
                       @"Main Course",
                       @"Desserts",
                       @"Beverages",
                       nil];
    
    [collectionList setDelegate:nil];
    [collectionList setDataSource:nil];
    [lblTitle setText:[arrCategoryList objectAtIndex:[[dicData valueForKey:@"categoryId"] integerValue]-1]];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    [self filterArray];
}
-(void)filterArray {
    
    
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
        //[self loadCurrentItem];
    [collectionList setDelegate:self];
    [collectionList setDataSource:self];
    [collectionList reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    //NSString *searchTerm = self.searches[section];
    //return [self.searchResults[searchTerm] count];
    //return 3;
    return arrItemsList.count;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    //    return [self.searches count];
    return 1;
    
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@",cv);
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    MenuItems* data = [arrItemsList objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    UILabel* lblName = (UILabel*)[cell viewWithTag:2];
    UIImageView* imgVItem = (UIImageView*)[cell viewWithTag:1];
    imgVItem.layer.cornerRadius = 8.0;
    imgVItem.layer.masksToBounds = YES;
    imgVItem.layer.borderWidth = 0;
    [lblName setText:data.itemTitle];
    
//    if (singleton.isEnglish) {
//        [btnCategory setImage:[UIImage imageNamed:[data valueForKey:@"ImageName"]] forState:UIControlStateNormal];
//        [btnCategory setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",[data valueForKey:@"ImageName"]]] forState:UIControlStateHighlighted];
//    }
//    else {
//        [btnCategory setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_ar",[data valueForKey:@"ImageName"]]] forState:UIControlStateNormal];
//        [btnCategory setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel_ar",[data valueForKey:@"ImageName"]]] forState:UIControlStateHighlighted];
//    }
  //  [btnCategory setImage:[UIImage imageNamed:@"btn_salads_sel_ar"] forState:UIControlStateNormal];
    [self loadImageFromUrl:data.imageThumb ImageView:imgVItem];
    
   // [btnCategory setBackgroundColor:[UIColor purpleColor]];
   // objc_setAssociatedObject(btnCategory, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
 //   [btnCategory addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self loadImageFromUrl:[data valueForKey:@"category_image_107x116"] ImageView:imgView];
    //[imgView setImage:[UIImage imageNamed:@""]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"SELECT");
//    NSMutableDictionary* dicData = [arrData objectAtIndex:indexPath.row];
//    
//    OrderController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderController"];
//    [self.navigationController pushViewController:controller animated:YES];
    //PhotoCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //self.image = cell.imageView.image;
    
    MenuItems* data = [arrItemsList objectAtIndex:indexPath.row];
    
    OrderController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderController"];
    NSMutableDictionary* dicData1 = [NSMutableDictionary dictionary];
    [dicData1 setValue:data.categoryId forKey:@"categoryId"];
    [dicData1 setValue:[NSNumber numberWithBool:YES] forKey:@"isSearch"];
    [dicData1 setValue:data.itemId forKey:@"itemId"];
    controller.dicData = dicData1;
    
    [self.view endEditing:YES];
    
    [self.navigationController pushViewController:controller animated:YES];
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

//
//  CategoryController.m
//  EMenu
//
//  Created by Soomro Shahid on 7/12/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "CategoryController.h"
#import "OrderController.h"
#import <objc/runtime.h>
#import "OrderDetailController.h"
#import "KGModal.h"
#import "MenuListController.h"
#define MENU_POPOVER_FRAME  CGRectMake(65, 115, 140, 88)

@interface CategoryController ()

@end

@implementation CategoryController
static char selectedBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    //[collectionList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];

    // Do any additional setup after loading the view.
    
    if(singleton.isEnglish){
        arrMenuDropDown = [NSArray arrayWithObjects:@"Main Menu", @"Logout", nil];
    }
    else {
        arrMenuDropDown = [NSArray arrayWithObjects:@"القائمة الرئيسية", @"تسجيل خروج", nil];
    }
    
    
    singleton.arrOrderItems = nil;
    singleton.arrOrderItems = [[NSMutableArray alloc]init];
    arrData = [Utility getPlistValuesArray:@"CategoriesList"];
    arrSearched = [Utility getPlistValuesArray:@"CategoriesList"];

    [collectionList setDelaysContentTouches:NO];
    
    isDataLoaded = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if(singleton.isEnglish){
        [lblCount setText:[NSString stringWithFormat:@"Item added: %ld",(unsigned long)singleton.arrOrderItems.count]];
   
    }
    else {
        [lblCount setText:[NSString stringWithFormat:@"تم إضافة السلعة: %ld",(unsigned long)singleton.arrOrderItems.count]];
    }
    
    [btnConfirmOrder setHidden:NO];
    if (singleton.arrOrderItems.count <= 0){
        [btnConfirmOrder setHidden:YES];
    }
    
    [txtSearch resignFirstResponder];
    [self.view endEditing:YES];
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    
    if(isDataLoaded)
        return;
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:singleton.loginDetail.result.restaurantId forKey:@"restaurantId"];
    [SERVICE_MODEL getAllMenu:parameters completionBlock:^(NSObject *response) {
        
        singleton.allMenuItems = [MenuBaseClass modelObjectWithDictionary:(NSDictionary *)response];
        [self createDropDown];
        isDataLoaded = YES;
       // arrData = [[response valueForKey:@"Result"] valueForKey:@"Categories"];
        //[collectionList reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
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
    
    return arrSearched.count;
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
    
    NSMutableDictionary* data = [arrSearched objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    UIButton* btnCategory = (UIButton*)[cell viewWithTag:1];
    btnCategory.imageView.layer.cornerRadius = 8.0;
    btnCategory.imageView.layer.masksToBounds = YES;
    btnCategory.imageView.layer.borderWidth = 0;
    
    if (singleton.isEnglish) {
        [btnCategory setImage:[UIImage imageNamed:[data valueForKey:@"ImageName"]] forState:UIControlStateNormal];
        [btnCategory setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",[data valueForKey:@"ImageName"]]] forState:UIControlStateHighlighted];
    }
    else {
        [btnCategory setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_ar",[data valueForKey:@"ImageName"]]] forState:UIControlStateNormal];
        [btnCategory setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel_ar",[data valueForKey:@"ImageName"]]] forState:UIControlStateHighlighted];
    }
    
    
    objc_setAssociatedObject(btnCategory, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    [btnCategory addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self loadImageFromUrl:[data valueForKey:@"category_image_107x116"] ImageView:imgView];
    //[imgView setImage:[UIImage imageNamed:@""]];
    return cell;
}
-(IBAction)selectCategory:(id)sender {
    
    
    if ([sender tag] == 16) {
        
        NSMutableDictionary* dicData = [NSMutableDictionary dictionary];
        [dicData setValue:@"16" forKey:@"categoryId"];
        [dicData setValue:[NSNumber numberWithBool:NO] forKey:@"isSearch"];
        
        OrderController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderController"];
        //[dicData setValue:[NSString stringWithFormat:@"%ld",row+1] forKey:@"categoryId"];
        [dicData setValue:[NSNumber numberWithBool:NO] forKey:@"isSearch"];
        
        controller.dicData = dicData;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    NSLog(@"SELECT");
    NSInteger row = [objc_getAssociatedObject(sender, &selectedBtn) integerValue];
    NSMutableDictionary* dicData = [arrSearched objectAtIndex:row];
//    OrderController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderController"];
//    [dicData setValue:[NSNumber numberWithBool:NO] forKey:@"isSearch"];
//    controller.dicData = dicData;
//    [self.navigationController pushViewController:controller animated:YES];
    
    MenuListController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"menuListController"];
    controller.dicData = dicData;
    [self.navigationController pushViewController:controller animated:YES];

}

//-(void)searchSelectedCategory:(NSMutableDictionary*)dic {
//   
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Name CONTAINS[cd] %@",txtSearch.text];
//    NSArray *filtered  = [arrData filteredArrayUsingPredicate:predicate];
//    NSLog(@"%@",filtered);
//    [arrSearched removeAllObjects];
//    arrSearched = nil;
//    arrSearched = [filtered mutableCopy];
//    [collectionList reloadData];
//    if (![Validation ValidateStringLength:txtSearch.text]) {
//        arrSearched = [arrData mutableCopy];
//    }
//
//    
//}

-(IBAction)searchArray {
    
    
    //NSLog(@"%@",txtSearch.text);
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Name CONTAINS[cd] %@",txtSearch.text];
//    NSArray *filtered  = [arrData filteredArrayUsingPredicate:predicate];
//    NSLog(@"%@",filtered);
//    [arrSearched removeAllObjects];
//    arrSearched = nil;
//    arrSearched = [filtered mutableCopy];
//    [collectionList reloadData];
//    if (![Validation ValidateStringLength:txtSearch.text]) {
//        arrSearched = [arrData mutableCopy];
//    }
}

-(IBAction)confirmOrder {
    
    OrderDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderDetailController"];
    controller.arrData = singleton.arrOrderItems;
    [self.navigationController pushViewController:controller animated:YES];
}



-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (arrData) {
        [arrData removeAllObjects];
        arrData = nil;
    }
    
    if (arrSearched) {
        [arrSearched removeAllObjects];
        arrSearched = nil;
    }
}


-(void)createDropDown {

    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    autocompleteTableView = [[DropDownTableView alloc] initWithFrame:CGRectMake(PX(imgSearchBg), PY(imgSearchBg)+HGT(imgSearchBg), WDT(imgSearchBg), 120) style:UITableViewStylePlain];
    [autocompleteTableView initialize];
    [txtSearch setDelegate:autocompleteTableView];
    [self.view addSubview:autocompleteTableView];

    // border radius
    [autocompleteTableView.layer setCornerRadius:20.0f];
    
    // border
    [autocompleteTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [autocompleteTableView.layer setBorderWidth:2.5f];
    
    // drop shadow
    [autocompleteTableView.layer setShadowColor:[UIColor blackColor].CGColor];
    [autocompleteTableView.layer setShadowOpacity:0.8];
    [autocompleteTableView.layer setShadowRadius:3.0];
    [autocompleteTableView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveSearchCategoryNotification:)
                                                 name:@"searchCategory"
                                               object:nil];

    
}

- (void) receiveSearchCategoryNotification:(NSNotification *) notification {
    
    MenuItems* item = [notification object];
    
    NSLog(@"%@",item);
    
    OrderController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderController"];
    NSMutableDictionary* dicData = [NSMutableDictionary dictionary];
    [dicData setValue:item.categoryId forKey:@"categoryId"];
    [dicData setValue:[NSNumber numberWithBool:YES] forKey:@"isSearch"];
    [dicData setValue:item.itemId forKey:@"itemId"];
    controller.dicData = dicData;
    
    [autocompleteTableView endEditing:YES];
    [txtSearch setText:@""];
    
    [self.view endEditing:YES];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    
    [autocompleteTableView reloadtable];
    [super viewDidDisappear:YES];
    
    
}
#pragma mark -
#pragma mark Actions

- (IBAction)showMenuPopOver:(id)sender
{
    // Hide already showing popover
    [menuPopover dismissMenuPopover];
    
    menuPopover = [[MLKMenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:arrMenuDropDown];
    
    menuPopover.menuPopoverDelegate = self;
    [menuPopover showInView:self.view];
}

#pragma mark -
#pragma mark MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover1 didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [menuPopover dismissMenuPopover];
    
    if (selectedIndex == 0) {
        [appDelegate setRootMenuController];
    }
    else if (selectedIndex == 1) {
//        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:[MCLocalization stringForKey:@"Alert"] message:@"Are you sure you want to logout" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//        [alert setTag:1];
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:[MCLocalization stringForKey:@"Alert"] message:@"Are you sure you want to logout" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"OK", nil];
        [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        
        // Alert style customization
        //[[av textFieldAtIndex:1] setSecureTextEntry:NO];
        [[av textFieldAtIndex:0] setPlaceholder:@"Email"];
        [[av textFieldAtIndex:1] setPlaceholder:@"Table Id"];
        [av setTag:1];
        [av show];
        
//        [alert show];
        //[appDelegate setRootLoginController];
    }
    NSLog(@"%@",self.navigationController.viewControllers);
//    NSString *title = [NSString stringWithFormat:@"%@ selected.",[arrMenuDropDown objectAtIndex:selectedIndex]];
//    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    
//    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld",(long)buttonIndex);
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            
            if ([Validation ValidateStringLength:[alertView textFieldAtIndex:0].text]) {
             
                if ([Validation ValidateStringLength:[alertView textFieldAtIndex:1].text]) {
                    
                    if ([[alertView textFieldAtIndex:0].text isEqualToString:singleton.loginDetail.result.email]) {
                        
                        if ([[alertView textFieldAtIndex:1].text isEqualToString:singleton.loginDetail.result.tableNumber]) {
                            [appDelegate setRootLoginController];
                        }
                        else {
                            SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], @"Email or Table Id is invalid")
                        }
                    }
                    else {
                        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], @"Email or Table Id is invalid")
                    }
                    
                }
                else {
                    SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], @"Enter Table Id")
                }
            }
            else {
                SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], @"Enter Email")
            }
            NSLog(@"1 %@", [alertView textFieldAtIndex:0].text);
            NSLog(@"2 %@", [alertView textFieldAtIndex:1].text);
           // [appDelegate setRootLoginController];
        }
    }
    else if(alertView.tag == 2) {
        
    }
}
-(IBAction)showInfo {
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 250)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 25;
    UIFont *welcomeLabelFont = [UIFont fontWithName:@"Optima-Bold" size:20.0];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"IShine Advertising Agency";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:welcomeLabel];
    
    
    UIImageView* imgLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 180, 180)];
    [imgLogo setImage:[UIImage imageNamed:@"ishine_icon"]];
    [contentView addSubview:imgLogo];
    [imgLogo setCenter:CGPointMake(contentView.center.x, contentView.center.y+20)];
//    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
//    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
//    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect) + 50;
//    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
//    infoLabel.text = @"KGModal is an easy drop in control that allows you to display any view "
//    "in a modal popup. The modal will automatically scale to fit the content view "
//    "and center it on screen with nice animations!";
//    infoLabel.numberOfLines = 6;
//    infoLabel.textColor = [UIColor whiteColor];
//    infoLabel.textAlignment = NSTextAlignmentCenter;
//    infoLabel.backgroundColor = [UIColor clearColor];
//    infoLabel.shadowColor = [UIColor blackColor];
//    infoLabel.shadowOffset = CGSizeMake(0, 1);
//    [contentView addSubview:infoLabel];
//    
//    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
//    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
//    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
//    [contentView addSubview:btn];
    
    //    [[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"SELECT");
//    NSMutableDictionary* dicData = [arrData objectAtIndex:indexPath.row];
//    
//    OrderController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"orderController"];
//    [self.navigationController pushViewController:controller animated:YES];
//    //PhotoCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    //self.image = cell.imageView.image;
//}



// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

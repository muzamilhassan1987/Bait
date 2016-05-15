//
//  DropDownTableView.m
//  EMenu
//
//  Created by Soomro Shahid on 8/9/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "DropDownTableView.h"

@implementation DropDownTableView


-(void)initialize {
    
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    self.hidden = YES;
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
  //  pastUrls = [singleton.allMenuItems mutableCopy];
  //  [pastUrls removeAllObjects];
//    for (int i=0;i<5;i++){
//        [pastUrls addObject:[singleton.allMenuItems.result.items objectAtIndex:i]];
//    }
//    pastUrls =  [[NSMutableArray alloc]initWithObjects:@"muzamil",@"hassan",@"khalid",@"muzamil1",@"faisal",@"muzami2l",@"muzamil",@"faraz", nil];
    autocompleteUrls = [[NSMutableArray alloc]init];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.hidden = NO;

    NSString *substring = [NSString stringWithString:textField.text];
    
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    
    [self searchAutocompleteEntriesWithSubstring:substring];
    
    return YES;
    
}



-(void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    
    
    [autocompleteUrls removeAllObjects];
    
    
    
//    for(NSString *curString in pastUrls)  {
//        
//        NSRange substringRange = [curString rangeOfString:substring];
//        
//        if (substringRange.location == 0) {
//            
//            [autocompleteUrls addObject:curString];
//            
//        }
//        
//    }
    
    if (![Validation ValidateStringLength:substring]) {
        [self reloadData];
        return;
    }
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemTitle CONTAINS[cd] %@",substring];
    //NSLog(@"%@",predicate);
    //NSLog(@"%@",substring);
    NSArray *filtered  = [singleton.allMenuItems.result.items filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",filtered);
    autocompleteUrls = nil;
    autocompleteUrls = [filtered mutableCopy];
    [self reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    NSLog(@"%ld",autocompleteUrls.count);
    
    if (autocompleteUrls.count>5) {
        [tableView  setFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 5*50)];
    }
    else {
      [tableView  setFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, autocompleteUrls.count*50)];
    }
    
    return autocompleteUrls.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"newFriendCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newFriendCell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UILabel* lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 6, 300, 18)];
        [cell addSubview:lblTitle];
        [lblTitle setFont:[UIFont fontWithName:@"Optima-Regular" size:14.0]];
        [lblTitle setTag:1];
        [lblTitle setTextColor:[UIColor colorWithRed:(121/255.f) green:(177/255.f) blue:(66/255.f) alpha:(255.f)]];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    MenuItems* item = [autocompleteUrls objectAtIndex:indexPath.row];
//    cell.textLabel.text = [autocompleteUrls objectAtIndex:indexPath.row];
    
    UILabel* lblTitle = (UILabel*)[cell viewWithTag:1];
    [lblTitle setText:item.itemTitle];

//    cell.textLabel.text = item.itemTitle;
//    cell
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"searchCategory"
     object:[autocompleteUrls objectAtIndex:indexPath.row]];
    
}
-(void)reloadtable {
    [autocompleteUrls removeAllObjects];
    [self reloadData];
}
@end

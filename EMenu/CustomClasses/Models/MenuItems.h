//
//  MenuItems.h
//
//  Created by Soomro Shahid on 7/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MenuItems : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *restaurantId;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *itemImage;
@property (nonatomic, strong) NSString *itemDetail;
@property (nonatomic, strong) NSString *itemInstruction;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *modified;
@property (nonatomic, strong) NSString *imageThumb;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *itemPrice;
@property (nonatomic, strong) NSString *currencyUnit;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

//
//  MenuItems.m
//
//  Created by Soomro Shahid on 7/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MenuItems.h"


NSString *const kMenuItemsRestaurantId = @"restaurant_id";
NSString *const kMenuItemsCategoryId = @"category_id";
NSString *const kMenuItemsItemImage = @"item_image";
NSString *const kMenuItemsItemDetail = @"item_detail";
NSString *const kMenuItemsItemInstruction = @"item_instruction";
NSString *const kMenuItemsCreated = @"created";
NSString *const kMenuItemsItemTitle = @"item_title";
NSString *const kMenuItemsModified = @"modified";
NSString *const kMenuItemsImageThumb = @"image_thumb";
NSString *const kMenuItemsItemId = @"item_id";
NSString *const kMenuItemsItemPrice = @"item_price";
NSString *const kMenuItemsItemCurrencyUnit = @"currency_unit";


@interface MenuItems ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MenuItems

@synthesize restaurantId = _restaurantId;
@synthesize categoryId = _categoryId;
@synthesize itemImage = _itemImage;
@synthesize itemDetail = _itemDetail;
@synthesize itemInstruction = _itemInstruction;
@synthesize created = _created;
@synthesize itemTitle = _itemTitle;
@synthesize modified = _modified;
@synthesize imageThumb = _imageThumb;
@synthesize itemId = _itemId;
@synthesize itemPrice = _itemPrice;
@synthesize currencyUnit = _currencyUnit;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.restaurantId = [self objectOrNilForKey:kMenuItemsRestaurantId fromDictionary:dict];
            self.categoryId = [self objectOrNilForKey:kMenuItemsCategoryId fromDictionary:dict];
            self.itemImage = [self objectOrNilForKey:kMenuItemsItemImage fromDictionary:dict];
            self.itemDetail = [self objectOrNilForKey:kMenuItemsItemDetail fromDictionary:dict];
            self.itemInstruction = [self objectOrNilForKey:kMenuItemsItemInstruction fromDictionary:dict];
            self.created = [self objectOrNilForKey:kMenuItemsCreated fromDictionary:dict];
            self.itemTitle = [self objectOrNilForKey:kMenuItemsItemTitle fromDictionary:dict];
            self.modified = [self objectOrNilForKey:kMenuItemsModified fromDictionary:dict];
            self.imageThumb = [self objectOrNilForKey:kMenuItemsImageThumb fromDictionary:dict];
            self.itemId = [self objectOrNilForKey:kMenuItemsItemId fromDictionary:dict];
            self.itemPrice = [self objectOrNilForKey:kMenuItemsItemPrice fromDictionary:dict];
            self.currencyUnit = [self objectOrNilForKey:kMenuItemsItemCurrencyUnit fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.restaurantId forKey:kMenuItemsRestaurantId];
    [mutableDict setValue:self.categoryId forKey:kMenuItemsCategoryId];
    [mutableDict setValue:self.itemImage forKey:kMenuItemsItemImage];
    [mutableDict setValue:self.itemDetail forKey:kMenuItemsItemDetail];
    [mutableDict setValue:self.itemInstruction forKey:kMenuItemsItemInstruction];
    [mutableDict setValue:self.created forKey:kMenuItemsCreated];
    [mutableDict setValue:self.itemTitle forKey:kMenuItemsItemTitle];
    [mutableDict setValue:self.modified forKey:kMenuItemsModified];
    [mutableDict setValue:self.imageThumb forKey:kMenuItemsImageThumb];
    [mutableDict setValue:self.itemId forKey:kMenuItemsItemId];
    [mutableDict setValue:self.itemPrice forKey:kMenuItemsItemPrice];
    [mutableDict setValue:self.currencyUnit forKey:kMenuItemsItemCurrencyUnit];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.restaurantId = [aDecoder decodeObjectForKey:kMenuItemsRestaurantId];
    self.categoryId = [aDecoder decodeObjectForKey:kMenuItemsCategoryId];
    self.itemImage = [aDecoder decodeObjectForKey:kMenuItemsItemImage];
    self.itemDetail = [aDecoder decodeObjectForKey:kMenuItemsItemDetail];
    self.itemInstruction = [aDecoder decodeObjectForKey:kMenuItemsItemInstruction];
    self.created = [aDecoder decodeObjectForKey:kMenuItemsCreated];
    self.itemTitle = [aDecoder decodeObjectForKey:kMenuItemsItemTitle];
    self.modified = [aDecoder decodeObjectForKey:kMenuItemsModified];
    self.imageThumb = [aDecoder decodeObjectForKey:kMenuItemsImageThumb];
    self.itemId = [aDecoder decodeObjectForKey:kMenuItemsItemId];
    self.itemPrice = [aDecoder decodeObjectForKey:kMenuItemsItemPrice];
    self.currencyUnit = [aDecoder decodeObjectForKey:kMenuItemsItemCurrencyUnit];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_restaurantId forKey:kMenuItemsRestaurantId];
    [aCoder encodeObject:_categoryId forKey:kMenuItemsCategoryId];
    [aCoder encodeObject:_itemImage forKey:kMenuItemsItemImage];
    [aCoder encodeObject:_itemDetail forKey:kMenuItemsItemDetail];
    [aCoder encodeObject:_itemInstruction forKey:kMenuItemsItemInstruction];
    [aCoder encodeObject:_created forKey:kMenuItemsCreated];
    [aCoder encodeObject:_itemTitle forKey:kMenuItemsItemTitle];
    [aCoder encodeObject:_modified forKey:kMenuItemsModified];
    [aCoder encodeObject:_imageThumb forKey:kMenuItemsImageThumb];
    [aCoder encodeObject:_itemId forKey:kMenuItemsItemId];
    [aCoder encodeObject:_itemPrice forKey:kMenuItemsItemPrice];
    [aCoder encodeObject:_currencyUnit forKey:kMenuItemsItemCurrencyUnit];
}

- (id)copyWithZone:(NSZone *)zone
{
    MenuItems *copy = [[MenuItems alloc] init];
    
    if (copy) {

        copy.restaurantId = [self.restaurantId copyWithZone:zone];
        copy.categoryId = [self.categoryId copyWithZone:zone];
        copy.itemImage = [self.itemImage copyWithZone:zone];
        copy.itemDetail = [self.itemDetail copyWithZone:zone];
        copy.itemInstruction = [self.itemInstruction copyWithZone:zone];
        copy.created = [self.created copyWithZone:zone];
        copy.itemTitle = [self.itemTitle copyWithZone:zone];
        copy.modified = [self.modified copyWithZone:zone];
        copy.imageThumb = [self.imageThumb copyWithZone:zone];
        copy.itemId = [self.itemId copyWithZone:zone];
        copy.itemPrice = [self.itemPrice copyWithZone:zone];
        copy.currencyUnit = [self.currencyUnit copyWithZone:zone];
    }
    
    return copy;
}


@end

//
//  MenuResult.m
//
//  Created by Soomro Shahid on 7/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MenuResult.h"
#import "MenuItems.h"


NSString *const kMenuResultItems = @"Items";
NSString *const kMenuResultTotalRecords = @"totalRecords";


@interface MenuResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MenuResult

@synthesize items = _items;
@synthesize totalRecords = _totalRecords;


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
    NSObject *receivedMenuItems = [dict objectForKey:kMenuResultItems];
    NSMutableArray *parsedMenuItems = [NSMutableArray array];
    if ([receivedMenuItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMenuItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMenuItems addObject:[MenuItems modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMenuItems isKindOfClass:[NSDictionary class]]) {
       [parsedMenuItems addObject:[MenuItems modelObjectWithDictionary:(NSDictionary *)receivedMenuItems]];
    }

    self.items = [NSArray arrayWithArray:parsedMenuItems];
            self.totalRecords = [[self objectOrNilForKey:kMenuResultTotalRecords fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForItems = [NSMutableArray array];
    for (NSObject *subArrayObject in self.items) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:kMenuResultItems];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalRecords] forKey:kMenuResultTotalRecords];

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

    self.items = [aDecoder decodeObjectForKey:kMenuResultItems];
    self.totalRecords = [aDecoder decodeDoubleForKey:kMenuResultTotalRecords];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_items forKey:kMenuResultItems];
    [aCoder encodeDouble:_totalRecords forKey:kMenuResultTotalRecords];
}

- (id)copyWithZone:(NSZone *)zone
{
    MenuResult *copy = [[MenuResult alloc] init];
    
    if (copy) {

        copy.items = [self.items copyWithZone:zone];
        copy.totalRecords = self.totalRecords;
    }
    
    return copy;
}


@end

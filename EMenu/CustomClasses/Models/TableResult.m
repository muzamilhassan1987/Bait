//
//  TableResult.m
//
//  Created by Soomro Shahid on 7/28/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "TableResult.h"


NSString *const kTableResultPhone = @"phone";
NSString *const kTableResultPassword = @"password";
NSString *const kTableResultRestaurantId = @"restaurant_id";
NSString *const kTableResultId = @"id";
NSString *const kTableResultTableId = @"table_id";
NSString *const kTableResultTableNumber = @"table_number";
NSString *const kTableResultTitle = @"title";
NSString *const kTableResultEmail = @"email";
NSString *const kTableResultCreated = @"created";
NSString *const kTableResultModified = @"modified";
NSString *const kTableResultName = @"name";


@interface TableResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TableResult

@synthesize phone = _phone;
@synthesize password = _password;
@synthesize restaurantId = _restaurantId;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize tableId = _tableId;
@synthesize tableNumber = _tableNumber;
@synthesize title = _title;
@synthesize email = _email;
@synthesize created = _created;
@synthesize modified = _modified;
@synthesize name = _name;


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
            self.phone = [self objectOrNilForKey:kTableResultPhone fromDictionary:dict];
            self.password = [self objectOrNilForKey:kTableResultPassword fromDictionary:dict];
            self.restaurantId = [self objectOrNilForKey:kTableResultRestaurantId fromDictionary:dict];
            self.resultIdentifier = [self objectOrNilForKey:kTableResultId fromDictionary:dict];
            self.tableId = [self objectOrNilForKey:kTableResultTableId fromDictionary:dict];
            self.tableNumber = [self objectOrNilForKey:kTableResultTableNumber fromDictionary:dict];
            self.title = [self objectOrNilForKey:kTableResultTitle fromDictionary:dict];
            self.email = [self objectOrNilForKey:kTableResultEmail fromDictionary:dict];
            self.created = [self objectOrNilForKey:kTableResultCreated fromDictionary:dict];
            self.modified = [self objectOrNilForKey:kTableResultModified fromDictionary:dict];
            self.name = [self objectOrNilForKey:kTableResultName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phone forKey:kTableResultPhone];
    [mutableDict setValue:self.password forKey:kTableResultPassword];
    [mutableDict setValue:self.restaurantId forKey:kTableResultRestaurantId];
    [mutableDict setValue:self.resultIdentifier forKey:kTableResultId];
    [mutableDict setValue:self.tableId forKey:kTableResultTableId];
    [mutableDict setValue:self.tableNumber forKey:kTableResultTableNumber];
    [mutableDict setValue:self.title forKey:kTableResultTitle];
    [mutableDict setValue:self.email forKey:kTableResultEmail];
    [mutableDict setValue:self.created forKey:kTableResultCreated];
    [mutableDict setValue:self.modified forKey:kTableResultModified];
    [mutableDict setValue:self.name forKey:kTableResultName];

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

    self.phone = [aDecoder decodeObjectForKey:kTableResultPhone];
    self.password = [aDecoder decodeObjectForKey:kTableResultPassword];
    self.restaurantId = [aDecoder decodeObjectForKey:kTableResultRestaurantId];
    self.resultIdentifier = [aDecoder decodeObjectForKey:kTableResultId];
    self.tableId = [aDecoder decodeObjectForKey:kTableResultTableId];
    self.tableNumber = [aDecoder decodeObjectForKey:kTableResultTableNumber];
    self.title = [aDecoder decodeObjectForKey:kTableResultTitle];
    self.email = [aDecoder decodeObjectForKey:kTableResultEmail];
    self.created = [aDecoder decodeObjectForKey:kTableResultCreated];
    self.modified = [aDecoder decodeObjectForKey:kTableResultModified];
    self.name = [aDecoder decodeObjectForKey:kTableResultName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_phone forKey:kTableResultPhone];
    [aCoder encodeObject:_password forKey:kTableResultPassword];
    [aCoder encodeObject:_restaurantId forKey:kTableResultRestaurantId];
    [aCoder encodeObject:_resultIdentifier forKey:kTableResultId];
    [aCoder encodeObject:_tableId forKey:kTableResultTableId];
    [aCoder encodeObject:_tableNumber forKey:kTableResultTableNumber];
    [aCoder encodeObject:_title forKey:kTableResultTitle];
    [aCoder encodeObject:_email forKey:kTableResultEmail];
    [aCoder encodeObject:_created forKey:kTableResultCreated];
    [aCoder encodeObject:_modified forKey:kTableResultModified];
    [aCoder encodeObject:_name forKey:kTableResultName];
}

- (id)copyWithZone:(NSZone *)zone
{
    TableResult *copy = [[TableResult alloc] init];
    
    if (copy) {

        copy.phone = [self.phone copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
        copy.restaurantId = [self.restaurantId copyWithZone:zone];
        copy.resultIdentifier = [self.resultIdentifier copyWithZone:zone];
        copy.tableId = [self.tableId copyWithZone:zone];
        copy.tableNumber = [self.tableNumber copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.created = [self.created copyWithZone:zone];
        copy.modified = [self.modified copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end

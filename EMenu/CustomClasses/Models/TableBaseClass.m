//
//  TableBaseClass.m
//
//  Created by Soomro Shahid on 7/28/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "TableBaseClass.h"
#import "TableResult.h"


NSString *const kTableBaseClassMessage = @"Message";
NSString *const kTableBaseClassResult = @"Result";
NSString *const kTableBaseClassResponse = @"Response";


@interface TableBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TableBaseClass

@synthesize message = _message;
@synthesize result = _result;
@synthesize response = _response;


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
            self.message = [self objectOrNilForKey:kTableBaseClassMessage fromDictionary:dict];
            self.result = [TableResult modelObjectWithDictionary:[dict objectForKey:kTableBaseClassResult]];
            self.response = [self objectOrNilForKey:kTableBaseClassResponse fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kTableBaseClassMessage];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kTableBaseClassResult];
    [mutableDict setValue:self.response forKey:kTableBaseClassResponse];

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

    self.message = [aDecoder decodeObjectForKey:kTableBaseClassMessage];
    self.result = [aDecoder decodeObjectForKey:kTableBaseClassResult];
    self.response = [aDecoder decodeObjectForKey:kTableBaseClassResponse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kTableBaseClassMessage];
    [aCoder encodeObject:_result forKey:kTableBaseClassResult];
    [aCoder encodeObject:_response forKey:kTableBaseClassResponse];
}

- (id)copyWithZone:(NSZone *)zone
{
    TableBaseClass *copy = [[TableBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.response = [self.response copyWithZone:zone];
    }
    
    return copy;
}


@end

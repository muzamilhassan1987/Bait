//
//  MenuBaseClass.m
//
//  Created by Soomro Shahid on 7/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MenuBaseClass.h"
#import "MenuResult.h"


NSString *const kMenuBaseClassMessage = @"Message";
NSString *const kMenuBaseClassResult = @"Result";
NSString *const kMenuBaseClassResponse = @"Response";


@interface MenuBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MenuBaseClass

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
            self.message = [self objectOrNilForKey:kMenuBaseClassMessage fromDictionary:dict];
            self.result = [MenuResult modelObjectWithDictionary:[dict objectForKey:kMenuBaseClassResult]];
            self.response = [self objectOrNilForKey:kMenuBaseClassResponse fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kMenuBaseClassMessage];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kMenuBaseClassResult];
    [mutableDict setValue:self.response forKey:kMenuBaseClassResponse];

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

    self.message = [aDecoder decodeObjectForKey:kMenuBaseClassMessage];
    self.result = [aDecoder decodeObjectForKey:kMenuBaseClassResult];
    self.response = [aDecoder decodeObjectForKey:kMenuBaseClassResponse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kMenuBaseClassMessage];
    [aCoder encodeObject:_result forKey:kMenuBaseClassResult];
    [aCoder encodeObject:_response forKey:kMenuBaseClassResponse];
}

- (id)copyWithZone:(NSZone *)zone
{
    MenuBaseClass *copy = [[MenuBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.response = [self.response copyWithZone:zone];
    }
    
    return copy;
}


@end

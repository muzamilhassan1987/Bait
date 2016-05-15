//
//  MenuBaseClass.h
//
//  Created by Soomro Shahid on 7/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MenuResult;

@interface MenuBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) MenuResult *result;
@property (nonatomic, strong) NSString *response;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

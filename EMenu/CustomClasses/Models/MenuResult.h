//
//  MenuResult.h
//
//  Created by Soomro Shahid on 7/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MenuResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) double totalRecords;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

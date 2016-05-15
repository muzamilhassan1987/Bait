//
//  TableResult.h
//
//  Created by Soomro Shahid on 7/28/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TableResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *restaurantId;
@property (nonatomic, strong) NSString *resultIdentifier;
@property (nonatomic, strong) NSString *tableId;
@property (nonatomic, strong) NSString *tableNumber;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *modified;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

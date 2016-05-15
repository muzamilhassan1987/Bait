//
//  Singleton.h
//  BasketBall
//
//  Created by faraz haider on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Singleton : NSObject
{
    
}
@property(nonatomic,strong)TableBaseClass* loginDetail;
@property(nonatomic,strong)MenuBaseClass* allMenuItems;
@property(nonatomic,strong)NSMutableArray* arrOrderItems;
@property(nonatomic,strong)NSMutableArray* arrTotalItems;
@property(nonatomic,assign)NSInteger iNotificationCount;
@property(nonatomic,assign)NSInteger iOfferCount;
//@property(nonatomic,assign)eTagController eCurrentTagController;
//@property(nonatomic,strong) UserBase* myAccountInfo;
@property( nonatomic ,assign  ) BOOL         isUserLogin;
@property( nonatomic ,assign  ) BOOL         isEnglish;


+(Singleton*) sharedSingletonInstance;



-(void) WifiAlert;



@end

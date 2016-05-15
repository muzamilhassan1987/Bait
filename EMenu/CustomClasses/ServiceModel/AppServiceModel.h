//
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "OrderedDictionary.h"
//#import "WKSocialSharing.h"
//#import <Reachability.h>

@interface AppServiceModel : AFHTTPRequestOperationManager{

    MBProgressHUD *progressHud;
    Reachability* hostReachable;
   // WKSocialSharing* pFbLogin;
}

+ (AppServiceModel *)sharedClient;

- (void) showProgressWithMessage:(NSString *)message;

- (void) hideProgressAlert;

-(void)loginUser:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getAllCategories:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getSelectedCategoryItems:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)addOrder:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getAllMenu:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock ;

-(void)updateCategory:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

@end

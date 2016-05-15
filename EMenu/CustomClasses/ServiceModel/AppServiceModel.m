//
#import "AppServiceModel.h"
#import "Services.h"
//
@implementation AppServiceModel

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (AppServiceModel *)sharedClient {
    static AppServiceModel *_serviceClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _serviceClient = [[AppServiceModel alloc] initWithBaseURL:[NSURL URLWithString:KWEB_SERVICE_BASE_URL]];
    });
    
    return _serviceClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSOperationQueue *operationQueue = self.operationQueue;
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"The internet is working via WWAN.");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                NSLog(@"The internet is working via WIFI.");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"No Network Connection! Please enable your internet");
                break;
                
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    return self;
    
}

# pragma mark - Show Progress

-(void) showProgressWithMessage:(NSString *)message
{
//    if(progressHud)
//    {
//        // only show hud
//    }
//    else{
//        //progressHud=nil;
//        
//        UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
//        progressHud=[[MBProgressHUD alloc]initWithView:[window.subviews lastObject]];
//        [window addSubview:progressHud];
//    }
    [progressHud removeFromSuperview];
    progressHud = nil;
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    progressHud=[[MBProgressHUD alloc]initWithView:[window.subviews lastObject]];
    [window addSubview:progressHud];
    
    [progressHud show:NO];
    [progressHud setLabelText:message];

}

-(void) hideProgressAlert{
    [progressHud hide:NO];
    //progressHud=nil;
}



-(id)getParseData:(NSDictionary*)responseObject{
    NSLog(@"%@",responseObject);
    NSString *responseString=[responseObject objectForKey:@"Response"];
    if(responseString)
    {
        NSDictionary *resultDictionary=[responseObject objectForKey:@"Result"];
        if([responseString isEqualToString:@"Success"])
        {
            return  resultDictionary;
        }
        else {
            [[[UIAlertView alloc]initWithTitle:@"Error" message:[responseObject objectForKey:@"Message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [self hideProgressAlert];
        }
    }
    return nil;
}


-(id)getParseDataArray:(NSDictionary*)responseObject{
    NSLog(@"%@",responseObject);
    NSString *responseString=[responseObject objectForKey:@"Response"];
    if(responseString)
    {
        NSArray *resultDictionary=[responseObject objectForKey:@"Result"];
        if([responseString isEqualToString:@"Success"])
        {
            return  resultDictionary;
        }
        else {
            [[[UIAlertView alloc]initWithTitle:@"Error" message:[responseObject objectForKey:@"Message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [self hideProgressAlert];
        }
    }
    return nil;
}


-(void)updateCategory:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    NSLog(@"%@",parameters);
    
http://www.albatilahtwigs.com/Categories/getCategories/restaurantId:1
    [self POST:KWEB_SERVICE_UPDATE_CATEGORY parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
         //             if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
         //                 block(responseObject);
         //             }
         //             else {
         //                 SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
         //             }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
         failBlock(error);
     }];
    
    
}

-(void)getAllMenu:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    NSLog(@"%@",parameters);
    
http://www.albatilahtwigs.com/Categories/getCategories/restaurantId:1
    [self POST:KWEB_SERVICE_GET_ALL_MENU parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
         //             if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
         //                 block(responseObject);
         //             }
         //             else {
         //                 SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
         //             }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
         failBlock(error);
     }];
    
    
}


-(void)getAllCategories:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    NSLog(@"%@",parameters);
    
   http://www.albatilahtwigs.com/Categories/getCategories/restaurantId:1
        [self POST:KWEB_SERVICE_GET_CATEGORIES parameters:parameters success:
         ^(AFHTTPRequestOperation *operation, id responseObject) {
    
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             [self hideProgressAlert];
             block(responseObject);
//             if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
//                 block(responseObject);
//             }
//             else {
//                 SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
//             }
    
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"Error: %@", error.localizedDescription);
             [self hideProgressAlert];
             [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
             failBlock(error);
         }];
    
    
}
-(void)getSelectedCategoryItems:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    NSLog(@"%@",parameters);
    
//http://www.albatilahtwigs.com/Menus/getItems/categoryId:3/restaurantId:2
    [self POST:KWEB_SERVICE_GET_SELECTED_CATEGORIES parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSLog(@"%@",singleton.arrOrderItems);
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
         //             if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
         //                 block(responseObject);
         //             }
         //             else {
         //                 SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
         //             }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
         failBlock(error);
     }];
    
    
}
-(void)addOrder:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[self showProgressWithMessage:@"Waiting..."];
    
    NSLog(@"%@",parameters);
    
    //http://www.albatilahtwigs.com/Menus/getItems/categoryId:3/restaurantId:2
    [self POST:KWEB_SERVICE_ADD_ORDERS parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         
         NSLog(@"SUCCESS");
         //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
//                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
//                          block(responseObject);
//                      }
//                      else {
//                          SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
//                      }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         NSLog(@"FAILURE");
         [self hideProgressAlert];
         [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
         failBlock(error);
     }];
    
    
}
-(void)loginUser:(NSMutableDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"login..."];
    
    NSLog(@"%@",parameters);
    
    [self POST:KWEB_SERVICE_LOGIN_CUSTOMER parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         
         if ([[responseObject valueForKey:@"Response"] isEqualToString:@"Success"]) {
             block(responseObject);
         }
         else {
             SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"Message"])
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
         failBlock(error);
     }];

    
}



- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(OrderedDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:nil constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}






-(void)getOffers:(OrderedDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
//    [self POST:KWEB_SERVICE_OFFER parameters:parameters success:
//     ^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         
//         block(responseObject);
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         NSLog(@"Error: %@", error.localizedDescription);
//         [self hideProgressAlert];
//         SIMPLE_ALERT(@"Error", error.localizedDescription);
//         failBlock(error);
//     }];
    
    
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/getallofferservice"
    [self postPathAbsoluteUrl:KWEB_SERVICE_GET_CATEGORIES
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                    
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
                      }
                      
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      failBlock(error);
                  }];
}

-(void)changePassword:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
//    [self POST:KWEB_SERVICE_UPDATE_PASSWORD parameters:parameters success:
//     ^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         NSLog(@"%@",responseObject);
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         [self hideProgressAlert];
//         block(responseObject);
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         NSLog(@"Error: %@", error.localizedDescription);
//         [self hideProgressAlert];
//         SIMPLE_ALERT(@"Error", error.localizedDescription);
//         failBlock(error);
//     }];
    
    [self postPathAbsoluteUrl:@"http://private-anon-1aa27893b-eradat.apiary-mock.com/updateuserpasswordservice"
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
                      }
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      failBlock(error);
                  }];
    
}



- (void)postPathAbsoluteUrl:(NSString *)urlString
                 parameters:(OrderedDictionary *)parameters
                showLoading:(NSString *)message
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure
{
    
    NSMutableArray *pairs=[NSMutableArray array];
    for (int i=0;i<parameters.allKeys.count;i++) {
        NSString*key=[parameters keyAtIndex:i];
        
        NSString *pairString=[NSString stringWithFormat:@"%@=%@",key,[parameters objectForKey:key]];
        [pairs addObject:pairString];
    }
    NSString *paramString=[pairs componentsJoinedByString:@"&"];
    
    //prepare json body data
    NSData *jsonData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    //mananger
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    
    //request//[[NSURL URLWithString:KWEB_SERVICE_LOGIN relativeToURL:self.baseURL] absoluteString]
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[[NSURL URLWithString:urlString relativeToURL:self.baseURL] absoluteString] parameters:nil error:nil];
    [request setHTTPBody:jsonData];
    
    
    //operation
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error) {
            if (failure) {
                
                if(operation.responseObject&&operation.responseObject) {
                    NSString *reason=[operation.responseObject objectForKey:@"reason"];
                    if(reason) {
                        
                        failure(error);
                    }
                }else {
                    //[self.operationQueue addOperation:operation];
                }
                failure(error);
            }
        }
    }];
    [self.operationQueue addOperation:operation];
    
}



-(void)getCompanyStaticEntities:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"----------- %@",parameters);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    [self postPathAbsoluteUrl:@"http://private-anon-1aa27893b-eradat.apiary-mock.com/companystaticentitiesservice"
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
                      }
                      
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      failBlock(error);
                  }];
}
-(void)getFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    [self postPathAbsoluteUrl:@"http://private-anon-1aa27893b-eradat.apiary-mock.com/getuserallfavoritescheduleservice"
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
                      }
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                       NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                  }];
    
    
//    [self POST:KWEB_SERVICE_USER_JOURNEY parameters:parameters success:
//     ^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         NSLog(@"%@",responseObject);
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         [self hideProgressAlert];
//         block(responseObject);
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         NSLog(@"Error: %@", error.localizedDescription);
//         [self hideProgressAlert];
//         SIMPLE_ALERT(@"Error", error.localizedDescription);
//         failBlock(error);
//     }];
}
-(void)addFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    [self postPathAbsoluteUrl:@"http://private-anon-1aa27893b-eradat.apiary-mock.com/adduserfavoritescheduleservice"
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
                      }
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                  }];
}
-(void)deleteFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    [self postPathAbsoluteUrl:@"http://private-anon-1aa27893b-eradat.apiary-mock.com/deleteuserfavoritescheduleservice"
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [responseObject valueForKey:@"message"])
                      }
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                  }];
}

-(void)searchDestination:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:@"Waiting..."];
    
    [self postPathAbsoluteUrl:@"http://202.141.243.212/eradat/searchdestinationservice"
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                  }];
}

@end

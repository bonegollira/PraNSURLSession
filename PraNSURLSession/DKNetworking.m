//
//  DKNetworking.m
//  PraNSURLSession
//
//  Created by daisuke on 2014/02/14.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import "DKNetworking.h"



static NSURLSession *kSession = nil;



@implementation DKNetworking



+ (void)initialize
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 10.f;
    config.allowsCellularAccess = NO;
    config.HTTPAdditionalHeaders  = @{
                                      @"Koayashi" : @"Daisuke",
                                       @"User-Agent": @"test"
                                      };
    
    kSession = [NSURLSession sessionWithConfiguration:config
                                             delegate:nil
                                        delegateQueue:[NSOperationQueue mainQueue]];
}




+ (void)doTaskWithURL:(NSURL *)URL
           completion:(void (^)(NSData *, NSURLResponse *, NSError *))completion
{
    NSURLSessionTask *task = [kSession dataTaskWithURL:URL
                                     completionHandler:completion];
    [task resume];
}






@end

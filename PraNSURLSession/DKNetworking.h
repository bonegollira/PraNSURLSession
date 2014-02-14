//
//  DKNetworking.h
//  PraNSURLSession
//
//  Created by daisuke on 2014/02/14.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import <Foundation/Foundation.h>



@interface DKNetworking : NSObject



+ (void)doTaskWithURL:(NSURL *)URL
           completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;



@end

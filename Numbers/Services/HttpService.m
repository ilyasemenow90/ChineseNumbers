//
//  HttpService.m
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

#import "HttpService.h"

@interface HttpService ()

@end

@implementation HttpService
- (void)requestAllNumber: (void (^)(BOOL, NSData *))completion {
    NSMutableURLRequest* request = [self createRequestFor:@"http://dev.tapptic.com/test/json.php"];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
          if (httpResponse.statusCode == 200) {
              completion(YES, data);
          } else {
              completion(NO, nil);
          }
    }];
    
    [dataTask resume];
}

- (NSMutableURLRequest *)createRequestFor: (NSString *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    return request;
}

@end


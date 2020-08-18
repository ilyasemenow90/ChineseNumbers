//
//  HttpService.h
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpService: NSObject
- (void)requestAllNumber: (void (^)(BOOL, NSData *))completion;
@end

NS_ASSUME_NONNULL_END

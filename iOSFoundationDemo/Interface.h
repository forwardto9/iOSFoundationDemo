//
//  Interface.h
//  iOSFoundationDemo
//
//  Created by uwei on 26/12/2017.
//  Copyright © 2017 uwei. All rights reserved.
//

#ifndef Interface_h
#define Interface_h

#import <Foundation/Foundation.h>
@protocol Agent
- (void)sendMessage:(NSString *)msg reply:(void(^)(NSString * replyMsg))reply;
@end

#endif /* Interface_h */

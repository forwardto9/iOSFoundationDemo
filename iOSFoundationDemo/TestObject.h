//
//  TestObject.h
//  ObjectiveCSyntaxDemo
//
//  Created by uwei on 3/15/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interface.h"

@interface TestObject : NSObject<NSCopying, NSMutableCopying, NSProgressReporting, NSXPCListenerDelegate,NSXPCProxyCreating, Agent>

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSUInteger age;
@property (nonatomic, strong) NSUndoManager *undoManager;
@property (nonatomic, weak) id <NSProgressReporting>report;
@property (nonatomic, strong) NSBundleResourceRequest *resourceRequest;


- (void)method1:(NSString *)p1 __deprecated;
- (void)method2:(__unused NSString *)p1  __API_DEPRECATED("No longer supported", macos(10.4, 10.8));

- (void)changeName:(NSString *)name;

- (NSUserActivity *)addUserActivity;

- (void)notificationMethod;
- (void)startRequestResources;

@end

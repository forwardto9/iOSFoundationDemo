//
//  TestObject.m
//  ObjectiveCSyntaxDemo
//
//  Created by uwei on 3/15/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import "TestObject.h"
#import <objc/runtime.h>

@implementation TestObject

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age {
    if (self = [super init]) {
        _age = age;
        _name = name;
    }
    
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
//    TestObject *copyObj = [[[self class] allocWithZone :zone] init];
//    copyObj.name = [self.name copy];
    return self;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    TestObject *obj = [[[self class] allocWithZone:zone] init];
    return obj;
}


- (id)valueForUndefinedKey:(NSString *)key {
    return @"";
}

- (void)method1:(NSString *)p1 {
    NSLog(@"%@", p1);
    NSLog(@"test 1 :%@", [[self valueForKey:@"x"] stringValue]);
    NSLog(@"属性 %@", [[self class] jcePropertiesWithEncodedTypes]);
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [NSURLConnection sendSynchronousRequest:[NSURLRequest new] returningResponse:nil error:nil];
//#pragma clang diagnostic pop
    
}

- (void)method2:(NSString *)p1 {
//    NSParameterAssert(p1);
    NSLog(@"%@", p1);
}

+ (NSDictionary *)jcePropertiesWithEncodedTypes {
    NSMutableDictionary *theProps = [NSMutableDictionary dictionary];
    objc_property_t *propList = class_copyPropertyList([self class], nil);
    for (int i = 0; propList[i] != nil; i++) {
        objc_property_t oneProp = propList[i];
        NSString *propName = @(property_getName(oneProp));
        NSString *attrs = @(property_getAttributes(oneProp));
        if ([attrs rangeOfString:@",R,"].location == NSNotFound) {
            NSArray *attrParts = [attrs componentsSeparatedByString:@","];
            if (attrParts != nil && [attrParts count] > 0) {
                NSString *propType = [attrParts[0] substringFromIndex:1];
                theProps[propName] = propType;
            }
        }
    }
    free(propList);
    return theProps;
}




@end

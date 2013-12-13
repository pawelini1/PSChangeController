//
//  NSObject+Unregistration.m
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/8/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import "NSObject+PSChangeController.h"
#import "NSNotificationCenter+PSChangeController.h"
#import <objc/runtime.h>
#import "PSChangeControllerExampleViewController.h" // fix

@implementation NSObject (PSChangeController)

#pragma mark - Observer

- (void)safelyAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    if (!observer || keyPath.length == 0)
        return;
    
    NSObject* realSelf = self;
    NSString* newKeyPath = keyPath;
    [NSObject convertSelf:&realSelf andKayPath:&newKeyPath];
    [realSelf addObserver:observer forKeyPath:newKeyPath options:options context:context];
    [realSelf appendDescriptor:[NSDictionary dictionaryWithObjectsAndKeys:
                                          observer, @"observer",
                                          newKeyPath, @"keyPath",
                                          options, @"options",
                                          context, @"context", nil]];
}

- (void)safelyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context{
    if (!observer || keyPath.length == 0)
        return;
    
    NSObject* realSelf = self;
    NSString* newKeyPath = keyPath;
    [NSObject convertSelf:&realSelf andKayPath:&newKeyPath];
    [realSelf removeObserver:observer forKeyPath:newKeyPath context:context];
    [realSelf removeDescriptor:[NSDictionary dictionaryWithObjectsAndKeys:
                                observer, @"observer",
                                newKeyPath, @"keyPath",
                                context, @"context", nil]];
}

- (void)safelyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    NSObject* realSelf = self;
    NSString* newKeyPath = keyPath;
    [NSObject convertSelf:&realSelf andKayPath:&newKeyPath];
    [realSelf removeObserver:observer forKeyPath:newKeyPath];
    [realSelf removeDescriptor:[NSDictionary dictionaryWithObjectsAndKeys:
                                observer, @"observer",
                                newKeyPath, @"keyPath",
                                nil]];
}

+(void)convertSelf:(NSObject**)newSelf andKayPath:(NSString**)keyPath{
    NSRange dotRange = [*keyPath rangeOfString:@"."];
    if(dotRange.location == NSNotFound)
        return;
    else{
        NSString* oldKeypath = *keyPath;
        *keyPath = [oldKeypath substringFromIndex:dotRange.location + 1];
        NSString* preKeyPath = [oldKeypath substringToIndex:dotRange.location];
        NSArray* path = [preKeyPath componentsSeparatedByString:@"."];
        for (NSString* nextKey in path) {
            *newSelf = [*newSelf valueForKey:nextKey];
        }
    }
}

#pragma mark - New properties

-(void)dealloc{
    NSMutableArray* descriptors = self.psDescriptors;
    if (descriptors.count > 0) {
        for (NSDictionary* descriptor in descriptors) {
            NSNotificationCenter* notificationCenter = descriptor[@"notificationCenter"];
            NSObject* observer = descriptor[@"observer"];
            if(notificationCenter){
                NSString* name = descriptor[@"aName"];
                [notificationCenter removeObserver:observer name:name object:self];
            }
            else{
                NSString* keyPath = descriptor[@"keyPath"];
                [self safelyRemoveObserver:observer forKeyPath:keyPath];
            }
        }
    }
}

- (void)setPsDescriptors:(NSMutableArray *)retArray
{
	objc_setAssociatedObject(self, @selector(psDescriptors), retArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray*)psDescriptors
{
	NSMutableArray* retArray = (NSMutableArray*)objc_getAssociatedObject(self, @selector(psDescriptors));
    if (!retArray) {
        retArray = [NSMutableArray array];
        [self setPsDescriptors:retArray];
    }
    return retArray;
}

-(void)appendDescriptor:(NSDictionary*)descriptor{
    if(![self.psDescriptors containsObject:descriptor])
        [self.psDescriptors addObject:descriptor];
}

-(void)removeDescriptor:(NSDictionary*)descriptor{
    if([self.psDescriptors containsObject:descriptor])
        [self.psDescriptors removeObject:descriptor];
}


@end

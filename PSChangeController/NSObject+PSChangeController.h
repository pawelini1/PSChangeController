//
//  NSObject+Unregistration.h
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/8/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PSChangeController)

- (void)safelyAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)safelyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;
- (void)safelyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

- (void)appendDescriptor:(NSDictionary*)descriptor;
- (void)removeDescriptor:(NSDictionary*)descriptor;

@property (nonatomic, strong) NSMutableArray* psDescriptors;

@end

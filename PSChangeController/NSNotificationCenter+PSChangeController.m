//
//  NSNotificationCenter+PSChangeController.m
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/9/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import "NSNotificationCenter+PSChangeController.h"
#import "NSObject+PSChangeController.h"

@implementation NSNotificationCenter (PSChangeController)

#pragma mark - Observer

- (void)safelyAddObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject{
    if (!anObject)
        return;

    [self addObserver:observer selector:aSelector name:aName object:anObject];
    [anObject appendDescriptor:@{@"notificationCenter" : self, @"observer": observer, @"aName" : aName}];

}

-(void)safelyRemoveObserver:(id)observer name:(NSString *)aName object:(id)anObject{
    if (!anObject)
        return;
    
    [self removeObserver:observer name:aName object:anObject];
    [anObject removeDescriptor:@{@"notificationCenter" : self, @"observer": observer, @"aName" : aName}];
}

@end

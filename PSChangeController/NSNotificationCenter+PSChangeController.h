//
//  NSNotificationCenter+PSChangeController.h
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/9/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (PSChangeController)

- (void)safelyAddObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (void)safelyRemoveObserver:(id)observer name:(NSString *)aName object:(id)anObject;

@end

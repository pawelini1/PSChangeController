//
//  PSChangeController.h
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/5/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSChangeDescriptor;

typedef void(^PSVoidBlock)(PSChangeDescriptor* descriptor);

@interface PSChangeController : NSObject

+ (id)sharedInstance;
- (void)whenDescriptorsChange:(NSArray*)descriptors fireBlock:(PSVoidBlock)block;

@end

#define PSPropertyDescriptorCreate(target, keyPath) [PSChangeDescriptor propertyDescriptorWithTarget:target andKeypath:keyPath]
#define PSTextFieldDescriptorCreate(target) [PSChangeDescriptor textFieldDescriptorWithTarget:target]
#define PSTextViewDescriptorCreate(target) [PSChangeDescriptor textViewDescriptorWithTarget:target]
#define PSValueChangedDescriptorCreate(target) [PSChangeDescriptor controlEventsDescriptorWithTarget:target event:UIControlEventValueChanged]

@interface PSChangeDescriptor : NSObject

+ (PSChangeDescriptor*)propertyDescriptorWithTarget:(id)target andKeypath:(NSString*)keypath;
+ (PSChangeDescriptor*)textFieldDescriptorWithTarget:(UITextField*)target;
+ (PSChangeDescriptor*)textViewDescriptorWithTarget:(UITextView*)target;
+ (PSChangeDescriptor*)controlEventsDescriptorWithTarget:(UIControl*)target event:(UIControlEvents)event;

- (id)initWithTarget:(id)target;
- (id)initWithTarget:(id)target andKeypath:(NSString*)keypath;

@property(weak, readonly) NSObject* target;
@property(copy, readonly) NSString* keypath;
@property(copy) PSVoidBlock fireBlock;
@end


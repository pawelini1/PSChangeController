//
//  PSChangeController.m
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/5/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import "PSChangeController.h"
#import "NSObject+PSChangeController.h"
#import "NSNotificationCenter+PSChangeController.h"

@implementation PSChangeController

+(id)sharedInstance{
    static PSChangeController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PSChangeController alloc] init];
    });
    return instance;
}

-(void)whenDescriptorsChange:(NSArray*)descriptors fireBlock:(PSVoidBlock)block{
    for (PSChangeDescriptor* descriptor in descriptors) {
        descriptor.fireBlock = block;
    }
}

@end

@implementation PSChangeDescriptor

@synthesize target = __target;
@synthesize keypath = __keypath;
@synthesize fireBlock = __fireBlock;

+(PSChangeDescriptor*)propertyDescriptorWithTarget:(id)target andKeypath:(NSString*)keypath{
    PSChangeDescriptor* descriptor = [[PSChangeDescriptor alloc] initWithTarget:target andKeypath:keypath];
    [descriptor.target safelyAddObserver:descriptor forKeyPath:descriptor.keypath options:0 context:nil];
    return descriptor;
}

+(PSChangeDescriptor*)textFieldDescriptorWithTarget:(UITextField*)target{
    PSChangeDescriptor* descriptor = [[PSChangeDescriptor alloc] initWithTarget:target];
    [[NSNotificationCenter defaultCenter] safelyAddObserver:descriptor
                                             selector:@selector(didChanged)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:target];
    return descriptor;
}

+(PSChangeDescriptor*)textViewDescriptorWithTarget:(UITextView*)target{
    PSChangeDescriptor* descriptor = [[PSChangeDescriptor alloc] initWithTarget:target];
    [[NSNotificationCenter defaultCenter] safelyAddObserver:descriptor
                                                   selector:@selector(didChanged)
                                                       name:UITextViewTextDidChangeNotification
                                                     object:target];
    return descriptor;
}

+(PSChangeDescriptor*)controlEventsDescriptorWithTarget:(UIControl*)target event:(UIControlEvents)event{
    PSChangeDescriptor* descriptor = [[PSChangeDescriptor alloc] initWithTarget:target];
    [target addTarget:descriptor action:@selector(didChanged) forControlEvents:event];
    return descriptor;
}

-(id)initWithTarget:(id)target{
    return [self initWithTarget:target andKeypath:nil];
}

-(id)initWithTarget:(id)target andKeypath:(NSString*)keypath{
    if (self = [super init]) {
        __target = target;
        __keypath = keypath;
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self didChanged];
}

-(void)didChanged{
    if(__fireBlock)
        __fireBlock(self);
}

@end

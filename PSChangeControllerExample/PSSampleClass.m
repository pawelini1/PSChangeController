//
//  PSSampleClass.m
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/10/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import "PSSampleClass.h"

@implementation PSSampleClass

@synthesize integerNumber = __integerNumber;

-(id)init{
    if (self = [super init]) {
        __integerNumber = [NSNumber numberWithInteger:250];
    }
    return self;
}

@end

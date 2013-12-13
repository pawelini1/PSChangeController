//
//  PSViewController.m
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/5/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import "PSChangeControllerExampleViewController.h"
#import "PSChangeController.h"

@interface PSChangeControllerExampleViewController ()

@end

@implementation PSChangeControllerExampleViewController

@synthesize button1 = __button1;
@synthesize button2 = __button2;
@synthesize button3 = __button3;
@synthesize label = __label;
@synthesize textfield = __textfield;
@synthesize textView = __textView;
@synthesize switchObj = __switchObj;
@synthesize slider = __slider;
@synthesize segmentedControl = __segmentedControl;
@synthesize stepper = __stepper;
@synthesize sampleClass = __sampleClass;

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        __sampleClass = [PSSampleClass new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray* descriptors = @[
                             PSPropertyDescriptorCreate(self.button1.titleLabel, @"text"),
                             PSPropertyDescriptorCreate(self.button3, @"titleLabel.text"),
                             PSTextFieldDescriptorCreate(self.textfield),
                             PSTextViewDescriptorCreate(self.textView),
                             PSValueChangedDescriptorCreate(self.slider),
                             PSValueChangedDescriptorCreate(self.switchObj),
                             PSValueChangedDescriptorCreate(self.segmentedControl),
                             PSValueChangedDescriptorCreate(self.stepper),
                             PSPropertyDescriptorCreate(self.sampleClass, @"integerNumber")
                             ];
    [[PSChangeController sharedInstance] whenDescriptorsChange:descriptors
                                                     fireBlock:^(PSChangeDescriptor *descriptor) {
                                                         NSLog(@"Object of class %@ did changed", NSStringFromClass(descriptor.target.class));
                                                         [self updateSumLabel];
                                                     }];
    
    descriptors = @[[PSChangeDescriptor controlEventsDescriptorWithTarget:self.button2 event:(UIControlEventTouchUpInside)]];
    [[PSChangeController sharedInstance] whenDescriptorsChange:descriptors
                                                     fireBlock:^(PSChangeDescriptor *descriptor) {
                                                         self.sampleClass.integerNumber = [NSNumber numberWithInteger:arc4random() % 1000];
                                                     }];
    
    descriptors = @[[PSChangeDescriptor controlEventsDescriptorWithTarget:self.button1 event:(UIControlEventTouchUpInside)],
                    [PSChangeDescriptor controlEventsDescriptorWithTarget:self.button3 event:(UIControlEventTouchUpInside)]];
    [[PSChangeController sharedInstance] whenDescriptorsChange:descriptors
                                                     fireBlock:^(PSChangeDescriptor *descriptor) {
                                                         UIButton* button = (UIButton*)descriptor.target;
                                                         NSString* newValue = [NSString stringWithFormat:@"%d", (arc4random() % 1000)];
                                                         [button setTitle:newValue
                                                                 forState:(UIControlStateNormal)];
                                                     }];
    
    [self updateSumLabel];
}

-(void)updateSumLabel{
    NSInteger sum = 0;
    sum += [__button1 titleForState:(UIControlStateNormal)].integerValue;
    sum += [__button2 titleForState:(UIControlStateNormal)].integerValue;
    sum += [__button3 titleForState:(UIControlStateNormal)].integerValue;
    sum += __textfield.text.integerValue;
    sum += __textView.text.integerValue;
    sum += __slider.value;
    sum += __stepper.value;
    sum *= (__switchObj.on ? 1.0f : -1.0f);
    sum = (__segmentedControl.selectedSegmentIndex == 0 ? sum * 10 : __segmentedControl.selectedSegmentIndex == 2 ? sum / 10 : sum);
    [__label setText:[NSString stringWithFormat:@"%d", sum]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

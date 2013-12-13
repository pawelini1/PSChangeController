//
//  PSViewController.h
//  PSChangeControllerExample
//
//  Created by Paweł Szymański on 12/5/13.
//  Copyright (c) 2013 Paweł Szymański. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSSampleClass.h"

@interface PSChangeControllerExampleViewController : UIViewController

@property(strong) IBOutlet UIButton* button1;
@property(strong) IBOutlet UIButton* button2;
@property(strong) IBOutlet UIButton* button3;
@property(strong) IBOutlet UILabel* label;
@property(strong) IBOutlet UITextField* textfield;
@property(strong) IBOutlet UITextView* textView;
@property(strong) IBOutlet UISwitch* switchObj;
@property(strong) IBOutlet UISlider* slider;
@property(strong) IBOutlet UISegmentedControl* segmentedControl;
@property(strong) IBOutlet UIStepper* stepper;
@property(strong) PSSampleClass* sampleClass;

@end

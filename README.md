PSChangeController
==================

PSChangeController is a tool that support developer in managing values changes across application runtime. It wraps KVO and NSNotificationCenter events in single block-style way. You only pass an array of descriptors that describe what king of changes you would like to know and a block of code to execute when any change happen. Futhermore there is no need to remember about removing observers at theirs deallocation. It's all done automatically.

##Usage:
1. Install PSChangeController to your project
2. Import `#import "PSChangeController.h"`
3. Define descriptors giving objects and descriptions of what type of change you would like to be notified.
4. Define action that should be performed when any change occur.
5. Combine 3 and 4 using `- (void)whenDescriptorsChange:(NSArray*)descriptors fireBlock:(PSVoidBlock)block;`

```objective-c
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
                                                         [self updateSumLabel];
                                                     }];
````

It's also OK to to define notifications for `UIControl` actions.
```objective-c
    descriptors = @[[PSChangeDescriptor controlEventsDescriptorWithTarget:self.button1 event:(UIControlEventTouchUpInside)],
                    [PSChangeDescriptor controlEventsDescriptorWithTarget:self.button3 event:(UIControlEventTouchUpInside)]];
    [[PSChangeController sharedInstance] whenDescriptorsChange:descriptors
                                                     fireBlock:^(PSChangeDescriptor *descriptor) {
                                                         UIButton* button = (UIButton*)descriptor.target;
                                                         NSString* newValue = [NSString stringWithFormat:@"%d", (arc4random() % 1000)];
                                                         [button setTitle:newValue
                                                                 forState:(UIControlStateNormal)];
                                                     }];
````

##Requirements:
1. ARC enabled
2. iOS 5 or later

##License:
>The MIT License (MIT)
>
>Copyright (c) 2013 Paweł Szymański
>
>Permission is hereby granted, free of charge, to any person obtaining a copy of
>this software and associated documentation files (the "Software"), to deal in
>the Software without restriction, including without limitation the rights to
>use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
>the Software, and to permit persons to whom the Software is furnished to do so,
>subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in all
>copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
>FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
>COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
>IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


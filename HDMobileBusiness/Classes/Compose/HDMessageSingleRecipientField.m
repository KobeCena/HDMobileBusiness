//
//  HDMessageSingleRecipientField.m
//  HDMobileBusiness
//
//  Created by Plato on 9/12/12.
//  Copyright (c) 2012 hand. All rights reserved.
//

#import "HDMessageSingleRecipientField.h"
#import "HDSinglePickerTextFiled.h"

@implementation HDMessageSingleRecipientField
@synthesize placeholder = _placeholder;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_placeholder);
    [super dealloc];
}

-(TTPickerTextField *)createViewForController:(TTMessageController *)controller
{
    TTPickerTextField* textField = [[[HDSinglePickerTextFiled alloc] init] autorelease];
    textField.dataSource = controller.dataSource;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.rightViewMode = UITextFieldViewModeAlways;
    if (controller.showsRecipientPicker) {
        UIButton* addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addButton addTarget:controller action:@selector(showRecipientPicker)
            forControlEvents:UIControlEventTouchUpInside];
        textField.rightView = addButton;
    }
    textField.placeholder = self.placeholder;
    return textField;
}

@end

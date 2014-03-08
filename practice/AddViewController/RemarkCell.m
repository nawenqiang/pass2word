//
//  RemarkCell.m
//  practice
//
//  Created by na on 14-3-5.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "RemarkCell.h"

@implementation RemarkCell
{
    void (^_completion)();
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _completion = ^{};
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    _completion();
}

- (void)setKeyboardCompletion:(void(^)())completion
{
    _completion = completion;
}
@end

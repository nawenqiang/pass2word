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
- (IBAction)keyboardNext:(id)sender
{
    if (_completion)
    {
        _completion();
    }
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
}


- (void)setKeyboardCompletion:(void(^)())completion
{
    _completion = completion;
}
@end

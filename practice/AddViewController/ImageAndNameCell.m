//
//  ImageAndNameCell.m
//  practice
//
//  Created by na on 14-3-4.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "ImageAndNameCell.h"

@implementation ImageAndNameCell
{
    void (^_completion)();
}
- (IBAction)keyboardNext:(id)sender
{
    _completion();
}
- (void)setKeyboardCompletion:(void(^)())completion
{
    _completion = completion;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _completion = ^{};
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

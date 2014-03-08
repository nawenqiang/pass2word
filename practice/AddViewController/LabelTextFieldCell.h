//
//  LabelTextFieldCell.h
//  practice
//
//  Created by na on 14-3-4.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelTextFieldCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentField;

- (void)setKeyboardCompletion:(void(^)())completion;

@end

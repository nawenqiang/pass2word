//
//  RemarkCell.h
//  practice
//
//  Created by na on 14-3-5.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemarkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
- (void)setKeyboardCompletion:(void(^)())completion;
@end

//
//  AddViewController.h
//  practice
//
//  Created by na on 14-3-3.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"



@protocol AddViewControllerDelegate <NSObject>

- (void)setCellData:(CellData *)data;

@end


@interface AddViewController : UIViewController

@property (weak, nonatomic) id <AddViewControllerDelegate> delegate;
-(void) getData: (CellData*) data;
@end

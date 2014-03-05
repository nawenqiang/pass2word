//
//  AddViewController.h
//  practice
//
//  Created by na on 14-3-3.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@protocol getDataDelegate <NSObject>

- (void)getCellData:(CellData *)data;

@end


@interface AddViewController : UIViewController

@property (weak, nonatomic) id <getDataDelegate> delegate;

@end

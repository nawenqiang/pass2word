//
//  MyCellViewController.h
//  practice
//
//  Created by na on 14-3-4.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"
#import "AddViewController.h"

@protocol  MyDetailViewControllerDelegate<NSObject>

-(void) sendID:(NSInteger) data;

@end


@interface MyDetailViewController : UIViewController<AddViewControllerDelegate>

@property (weak, nonatomic) id<MyDetailViewControllerDelegate> delegate;
-(void) getData: (CellData*)data;
@end

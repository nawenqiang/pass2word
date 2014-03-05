//
//  ViewController.h
//  practice
//
//  Created by na on 14-3-3.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

@interface MyViewController : UIViewController<getDataDelegate>

@property (weak, nonatomic) id<getDataDelegate> delegate;


@end

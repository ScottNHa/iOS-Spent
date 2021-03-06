//
//  SPAddViewController.h
//  Spent
//
//  Created by Scott Ha on 3/13/16.
//  Copyright © 2016 HappyViet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MasterTransitionDelegate;

@interface SPAddViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) id <MasterTransitionDelegate> masterTransitionDelegate;
@property (nonatomic, strong) NSString *name, *comment, *category;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSDate *date;

@end

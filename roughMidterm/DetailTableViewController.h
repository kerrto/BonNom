//
//  DetailTableViewController.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-11.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//
#import <ChameleonFramework/Chameleon.h>
#import <UIKit/UIKit.h>
#import "Lesson.h"

@interface DetailTableViewController : UITableViewController

@property (nonatomic, strong) Lesson *lesson;

@property (nonatomic, strong) NSMutableArray *questionsInLesson;

@end

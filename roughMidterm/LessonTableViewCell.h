//
//  LessonTableViewCell.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-09.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "Lesson.h"
#import "Question.h"
#import <UIKit/UIKit.h>

@interface LessonTableViewCell : UITableViewCell
@property (strong, nonatomic) Lesson* lessonObject;
@property (nonatomic,strong) NSArray *questions;
@property (nonatomic, strong) NSMutableArray *questionArrayChange;

- (IBAction)lessonSwitch:(UISwitch *)sender;




@end

//
//  ViewController.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-04.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonTableViewCell.h"


@interface ViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) NSMutableArray *questionArray;
@property (strong, nonatomic) LessonTableViewCell *cell;
@property (copy, nonatomic) NSArray *allQuestions;





//Set up NSNotificationCenter

//-(void)postNotificationWithString: (NSString)




@end


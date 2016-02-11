//
//  ViewController.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-04.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "LessonTableViewCell.h"


@interface ViewController : UIViewController


@property (strong, nonatomic) NSMutableArray *questionArray;
@property (copy, nonatomic) NSArray *allQuestions;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;







@end


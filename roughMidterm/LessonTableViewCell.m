//
//  LessonTableViewCell.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-09.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "LessonTableViewCell.h"
#import "JSONParse.h"
#import "Question.h"
#import "Lesson.h"
#import "LessonTableViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "Answer+CoreDataProperties.h"


@interface LessonTableViewCell()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *Lesson;
@property (strong, nonatomic) IBOutlet UILabel *mEnd1;
@property (strong, nonatomic) IBOutlet UILabel *mEnd2;
@property (strong, nonatomic) IBOutlet UILabel *mEnd3;
@property (strong, nonatomic) IBOutlet UILabel *mEnd4;
@property (strong, nonatomic) IBOutlet UILabel *fEnd1;
@property (strong, nonatomic) IBOutlet UILabel *fEnd2;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSFetchedResultsController* fetchedResultsController;





@end

@implementation LessonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setLessonObject:(Lesson *)lessonObject
{
    _lessonObject = lessonObject;
    self.Lesson.text= lessonObject.name;
    self.mEnd1.text=[lessonObject.masculin objectAtIndex:0];
    self.mEnd2.text=[lessonObject.masculin objectAtIndex:1];
    self.mEnd3.text=[lessonObject.masculin objectAtIndex:2];
    self.mEnd4.text=[lessonObject.masculin objectAtIndex:3];
    self.fEnd1.text=[lessonObject.feminin objectAtIndex:0];
    self.fEnd2.text=[lessonObject.feminin objectAtIndex:1];
    [self updateScoreLabel];
    
}


- (IBAction)lessonSwitch:(UISwitch*)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switch" object:self userInfo:@{@"lessonObject":self.lessonObject,@"switchState":@(sender.on)}];
}


-(void)updateScoreLabel {
    
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext=del.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Answer"];
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lesson = %@", self.lessonObject.name];
    
        request.predicate = predicate;
    
    NSLog(@"%@",predicate);
    
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"%@",results);
        NSLog(@"Error fetching Answer objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
        }
    
    NSMutableArray *correctAnswerArray=[[NSMutableArray alloc]init];
   
    
    for (Answer *answer in results) {
      
        if ([answer.correct isEqualToNumber:@(1)]) {
            [correctAnswerArray addObject:answer];
        }
        }
    NSInteger accuracy = (float) (correctAnswerArray.count)/(results.count)*100;
    
    NSLog(@"%ld",(long)accuracy);
    
    NSString *accuracyString=[@(accuracy) stringValue];
    
    self.scoreLabel.text=accuracyString;
}



@end

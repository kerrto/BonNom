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
@property (strong, nonatomic) IBOutlet UILabel *fEnd3;
@property (strong, nonatomic) IBOutlet UILabel *maccend1;
@property (strong, nonatomic) IBOutlet UILabel *maccend2;
@property (strong, nonatomic) IBOutlet UILabel *maccend3;
@property (strong, nonatomic) IBOutlet UILabel *macced4;
@property (strong, nonatomic) IBOutlet UILabel *faccend1;
@property (strong, nonatomic) IBOutlet UILabel *faccend2;
@property (strong, nonatomic) IBOutlet UILabel *faccend3;

@property (strong, nonatomic) IBOutlet UIProgressView *mpr1;

@property (strong, nonatomic) IBOutlet UIProgressView *mpr2;

@property (strong, nonatomic) IBOutlet UIProgressView *mpr3;

@property (strong, nonatomic) IBOutlet UIProgressView *mpr4;

@property (strong, nonatomic) IBOutlet UIProgressView *fpr1;

@property (strong, nonatomic) IBOutlet UIProgressView *fpr2;

@property (nonatomic, strong) NSMutableDictionary *resultsDict;







@property (strong, nonatomic) NSFetchedResultsController* fetchedResultsController;

@property (strong,nonatomic) NSArray *results;




@end

@implementation LessonTableViewCell

- (void)awakeFromNib {
    self.Lesson.layer.cornerRadius=10;
    self.Lesson.clipsToBounds = YES;
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
    
    if (lessonObject.feminin.count>2)
    {
        
        self.fEnd3.text=[lessonObject.feminin objectAtIndex:2];
    }
    
    [self updateScoreLabel];
    [self updateQuestionScoreLabels];
    
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
    
    
    NSError *error = nil;
    self.results = [managedObjectContext executeFetchRequest:request error:&error];
    if (!self.results) {
        NSLog(@"%@",self.results);
        NSLog(@"Error fetching Answer objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableArray *correctAnswerArray=[[NSMutableArray alloc]init];
    
    
    for (Answer *answer in self.results) {
        
        if ([answer.correct isEqualToNumber:@(1)]) {
            [correctAnswerArray addObject:answer];
        }
    }
    NSInteger accuracy = (float) (correctAnswerArray.count)/(self.results.count)*100;
    
    NSString *accuracyString=[@(accuracy) stringValue];
    
    if ((long)accuracy<0) {
        accuracyString=@"0";
    }
    
    NSString *percentString=@"%";
    
    NSString *scoreLabelString=[accuracyString stringByAppendingString:percentString];
    
    
    self.scoreLabel.text=scoreLabelString;
    
    
}

-(void)questionAccuracyCalc {
    
    self.resultsDict = [[NSMutableDictionary alloc]init];
    
    for (Answer *answer in self.results) {
        
        if (![self.resultsDict objectForKey:answer.question]) {
            
            [self.resultsDict setObject:[@[@0,@0,@0]mutableCopy] forKey:answer.question];
        }
        NSMutableArray *questionCounts = self.resultsDict[answer.question];
        
        int correct = [answer.correct intValue];
        
        if (correct == 1) {
            questionCounts[1] = @([questionCounts[1] integerValue] +1);
        }
        questionCounts[0] = @([questionCounts[0] integerValue] +1);
        
        questionCounts[2] = @([questionCounts[1] floatValue] / [questionCounts[0] floatValue]);
    }
}

-(void)updateQuestionScoreLabels {
    
    [self questionAccuracyCalc];
    
    //QuestionLabel1
    
    NSArray *a = self.resultsDict[[self.lessonObject.masculin objectAtIndex:0]];
    
    float accuracy = [[a objectAtIndex:2] floatValue];
    
    self.mpr1.progress = accuracy;
    
    NSString *accuracyPercentage = [[NSNumber numberWithFloat:roundf(accuracy *100)] stringValue];
    
    self.maccend1.text = accuracyPercentage;
    
    //QuestionLabel2
    
    NSArray *b = self.resultsDict[[self.lessonObject.masculin objectAtIndex:1]];
    
    float accuracy2 = [[b objectAtIndex:2] floatValue];
    
    self.mpr2.progress = accuracy2;
    
    NSString *accuracyPercentage2 = [[NSNumber numberWithFloat:roundf(accuracy2 *100)] stringValue];
    
    self.maccend2.text = accuracyPercentage2;
    
    //QuestionLabel3
    
    
    NSArray *c = self.resultsDict[[self.lessonObject.masculin objectAtIndex:2]];
    
    float accuracy3 = [[c objectAtIndex:2] floatValue];
    
    self.mpr3.progress = accuracy3;
    
    NSString *accuracyPercentage3 = [[NSNumber numberWithFloat:roundf(accuracy3 *100)] stringValue];
    
    self.maccend3.text = accuracyPercentage3;
    
    //QuestionLabel4
    
    NSArray *d = self.resultsDict[[self.lessonObject.masculin objectAtIndex:3]];
    
    float accuracy4 = [[d objectAtIndex:2] floatValue];
    
    self.mpr4.progress = accuracy4;
    
    NSString *accuracyPercentage4 = [[NSNumber numberWithFloat:roundf(accuracy4 *100)] stringValue];
    
    self.macced4.text = accuracyPercentage4;
    
    //QuestionLabel5
    
    NSArray *e = self.resultsDict[[self.lessonObject.feminin objectAtIndex:0]];
    
    float accuracy5 = [[e objectAtIndex:2] floatValue];
    
    self.fpr1.progress = accuracy5;
    
    NSString *accuracyPercentage5 = [[NSNumber numberWithFloat:roundf(accuracy5 *100)] stringValue];
    
    self.faccend1.text = accuracyPercentage5;
    
    //QuestionLabel6
    
    NSArray *f = self.resultsDict[[self.lessonObject.feminin objectAtIndex:1]];
    
    float accuracy6 = [[f objectAtIndex:2] floatValue];
    
    self.fpr2.progress = accuracy6;
    
    NSString *accuracyPercentage6 = [[NSNumber numberWithFloat:roundf(accuracy6 *100)] stringValue];
    
    self.faccend2.text = accuracyPercentage6;
    
    
}



@end

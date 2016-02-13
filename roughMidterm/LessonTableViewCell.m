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
    
    NSLog(@"%@",predicate);
    
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

-(void)updateQuestionScoreLabels {
    
    NSMutableArray *question1=[[NSMutableArray alloc]init];
    NSMutableArray *question2=[[NSMutableArray alloc]init];
    NSMutableArray *question3=[[NSMutableArray alloc]init];
    NSMutableArray *question4=[[NSMutableArray alloc]init];
    NSMutableArray *question5=[[NSMutableArray alloc]init];
    NSMutableArray *question6=[[NSMutableArray alloc]init];
    NSMutableArray *question7=[[NSMutableArray alloc]init];
    
    for (Answer *answer in self.results) {
        if ([answer.question isEqualToString:[self.lessonObject.masculin objectAtIndex:0]]) {
            [question1 addObject:answer];
        }
        
        if ([answer.question isEqualToString:[self.lessonObject.masculin objectAtIndex:1]]) {
            [question2 addObject:answer];
        }
        
        if ([answer.question isEqualToString:[self.lessonObject.masculin objectAtIndex:2]]) {
            [question3 addObject:answer];
        }
    
    
        if ([answer.question isEqualToString:[self.lessonObject.masculin objectAtIndex:3]]) {
            [question4 addObject:answer];
        }
 
        
        if ([answer.question isEqualToString:[self.lessonObject.feminin objectAtIndex:0]]) {
            [question5 addObject:answer];
        }
        
        if ([answer.question isEqualToString:[self.lessonObject.feminin objectAtIndex:1]]) {
            [question6 addObject:answer];
        }
        
        if (self.lessonObject.feminin.count>2) {
            
            if ([answer.question isEqualToString:[self.lessonObject.feminin objectAtIndex:2]]) {
                [question7 addObject:answer];
            }
        }
        
        NSMutableArray *corrAnswer1=[[NSMutableArray alloc]init];
        NSMutableArray *corrAnswer2=[[NSMutableArray alloc]init];
        NSMutableArray *corrAnswer3=[[NSMutableArray alloc]init];
        NSMutableArray *corrAnswer4=[[NSMutableArray alloc]init]; NSMutableArray *corrAnswer5=[[NSMutableArray alloc]init];   NSMutableArray *corrAnswer6=[[NSMutableArray alloc]init];
           NSMutableArray *corrAnswer7=[[NSMutableArray alloc]init];
        
        for (Answer *answer in question1) {
            if ([answer.correct isEqualToNumber:@(1)]) {
                [corrAnswer1 addObject:answer];
            }
        }
        
        for (Answer *answer in question2) {
            if ([answer.correct isEqualToNumber:@(1)]) {
                [corrAnswer2 addObject:answer];
            }
        }
        
        for (Answer *answer in question3) {
            if ([answer.correct isEqualToNumber:@(1)]) {
                [corrAnswer3 addObject:answer];
            }
        }
        
        for (Answer *answer in question4) {
            if ([answer.correct isEqualToNumber:@(1)]) {
                [corrAnswer4 addObject:answer];
            }
        }
        for (Answer *answer in question5) {
            if ([answer.correct isEqualToNumber:@(1)]) {
                [corrAnswer5 addObject:answer];
            }
        }
        
        for (Answer *answer in question6) {
            if ([answer.correct isEqualToNumber:@(1)]) {
                [corrAnswer6 addObject:answer];
            }
        }
        
        if (self.lessonObject.feminin.count>2){
        for (Answer *answer in question7) {
            if ([answer.correct isEqualToNumber:@(1)]) {
                [corrAnswer7 addObject:answer];
            }
        }
        }
        
        //find the accuracy for each question
        
        //question 1
        
        float decimalaccuracy1 = (float) (corrAnswer1.count)/(question1.count);
        
        NSInteger accuracy1= (float)decimalaccuracy1 *100;
        
        NSString *question1String=[@(accuracy1) stringValue];
        
        if ((long)accuracy1<=0) {
            question1String=@"0";
        }
        
        NSString *percentString=@"%";
        
        NSString *scoreLabelString1=[question1String stringByAppendingString:percentString];
        
        if (decimalaccuracy1<=0) {
            self.mpr1.progress=.05;
        }
        
        self.mpr1.progress=decimalaccuracy1;
        
        self.maccend1.text=scoreLabelString1;
        
        //question 2
        
        float decimalaccuracy2 = (float) (corrAnswer2.count)/(question2.count);
        
        NSInteger accuracy2= (float)decimalaccuracy2 *100;
        
        NSString *question2String=[@(accuracy2) stringValue];
        
        if ((long)accuracy2<=0) {
            question2String=@"0";
        }
        
        NSString *scoreLabelString2=[question2String stringByAppendingString:percentString];
        
        if (decimalaccuracy2<=0) {
            self.mpr2.progress=.05;
        }
        self.mpr2.progress = decimalaccuracy2;
        
        self.maccend2.text=scoreLabelString2;
        
        //question 3
        
        float decimalaccuracy3 = (float) (corrAnswer3.count)/(question3.count);
        
        NSInteger accuracy3= (float)decimalaccuracy3 *100;
        
        NSString *question3String=[@(accuracy3) stringValue];
        
        if ((long)accuracy3<=0) {
            question3String=@"0";
        }
        
        NSString *scoreLabelString3=[question3String stringByAppendingString:percentString];
        
        if (decimalaccuracy3<0) {
            self.mpr3.progress=.05;
        }
        self.mpr3.progress=decimalaccuracy3;
        self.maccend3.text=scoreLabelString3;
        


    //question 4
    
    float decimalaccuracy4 = (float) (corrAnswer4.count)/(question4.count);
        
    NSInteger accuracy4= (float)decimalaccuracy4 *100;
        
    NSString *question4String=[@(accuracy4) stringValue];
    
    if ((long)accuracy4<0) {
        question4String=@"0";
    }
    
    NSString *scoreLabelString4=[question4String stringByAppendingString:percentString];
    
    
        if (decimalaccuracy4<=0) {
            self.mpr4.progress=.05;
        }
        
    self.mpr4.progress=decimalaccuracy4;
    self.macced4.text=scoreLabelString4;
    
    
    //question 5
    
    float decimalaccuracy5 = (float) (corrAnswer5.count)/(question5.count);
        
    NSInteger accuracy5= (float)decimalaccuracy5 *100;
    
    NSString *question5String=[@(accuracy5) stringValue];
    
    if ((long)accuracy5<0) {
        question5String=@"0";
    }
    
    NSString *scoreLabelString5=[question5String stringByAppendingString:percentString];
    
        if (decimalaccuracy5<=0) {
            self.fpr1.progress=.05;
        }
        
    self.faccend1.text=scoreLabelString5;
    
    self.fpr1.progress=decimalaccuracy5;

    
    //question 6
    
    float decimalaccuracy6 = (float) (corrAnswer6.count)/(question6.count);
        
    NSInteger accuracy6= (float)decimalaccuracy6 *100;
        
    NSString *question6String=[@(accuracy6) stringValue];
    
    if ((long)accuracy6<0) {
        question6String=@"0";
    }
        if ([question6String isEqualToString:@"0"]) {
            self.fpr2.progress=0;
        }
        
        
    
    NSString *scoreLabelString6=[question6String stringByAppendingString:percentString];
    
    self.faccend2.text=scoreLabelString6;
        self.fpr2.progress=decimalaccuracy6;
        
        
        
        if (self.lessonObject.feminin.count>2) {
            
            //question 7
            
            NSInteger accuracy7 = (float) (corrAnswer7.count)/(question7.count)*100;
            
            NSString *question7String=[@(accuracy7) stringValue];
            
            if ((long)accuracy7<0) {
                question7String=@"0";
            }
            
            NSString *scoreLabelString7=[question7String stringByAppendingString:percentString];
            
            self.faccend3.text=scoreLabelString7;
            
            
        
    }
    
}
}
@end

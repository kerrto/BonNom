//
//  ViewController.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-04.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//
#import <ChameleonFramework/Chameleon.h>
#import "ViewController.h"
#import "Question.h"
#import "LessonTableViewController.h"
#import "Lesson.h"
#import "JSONParse.h"
#import "AppDelegate.h"



@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) Question *currentQuestion;
@property (strong, nonatomic) NSString *questionString;
@property (strong, nonatomic) IBOutlet UILabel *correctLabel;


@property (strong, nonatomic) IBOutlet UISwitch *endSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *wordSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *exceptionSwitch;
@property (strong, nonatomic) NSMutableArray *mixQuestionArray;
@property (strong, nonatomic) IBOutlet UIButton *masculinButton;
@property (strong, nonatomic) IBOutlet UIButton *femininButton;
@property (strong, nonatomic) IBOutlet UIImageView *eiffelTower;

- (IBAction)masculinButton:(id)sender;
- (IBAction)femininButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    JSONParse *json=[[JSONParse alloc]init];
    [json loadEndingQuestionWithJSON];
    self.allQuestions=json.questions;
    self.questionArray=json.questions;
     [self updateQuestionLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (changeQuestionArray:) name:@"switch" object:nil];
    
    NSArray *colors = @[[UIColor flatSkyBlueColor], [UIColor flatSkyBlueColorDark]];
    
    self.view.backgroundColor = [UIColor colorWithGradientStyle:(UIGradientStyle)UIGradientStyleTopToBottom withFrame:self.view.frame andColors:colors];
    
    self.correctLabel.textColor=[UIColor flatYellowColor];
    
    self.questionLabel.layer.cornerRadius=10;
    self.questionLabel.clipsToBounds = YES;
    
    self.eiffelTower.image=[UIImage imageNamed:@"eiffel-tower-hi.png"];
    

   self.title = @"Quiz";
    
    self.masculinButton.layer.cornerRadius = 10;
    self.masculinButton.clipsToBounds = YES;
    
    self.femininButton.layer.cornerRadius = 10;
    self.masculinButton.clipsToBounds = YES;
    
//    self.tabBarItem.image =
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createQuestionArray
{
   
  if (self.questionArray.count==0)
      
  {
        
    self.correctLabel.text = @"You have to toggle a lesson";
      self.correctLabel.textColor=[UIColor flatYellowColor];
      
      [self.mixQuestionArray removeAllObjects];
        
    }
    
  else
      
  {
      
    BOOL endSwtichOn=(self.endSwitch.on);
    BOOL wordSwitchOn=(self.wordSwitch.on);
    BOOL exceptionSwitchOn=(self.exceptionSwitch.on);
  
    NSUInteger questionArrayCount=self.questionArray.count;
    int questionInt=(int)questionArrayCount;
    int result=arc4random_uniform(questionInt);
   
 
    
    self.currentQuestion=[self.questionArray objectAtIndex:result];
    self.mixQuestionArray=[[NSMutableArray alloc]init];
    
    if (self.endSwitch.on)
    {
        [self.mixQuestionArray addObject:self.currentQuestion.ending];
    }
    if (self.wordSwitch.on)
    {
        NSUInteger wordArrayCount=self.currentQuestion.words.count;
        int wordInt=(int)wordArrayCount;
        int wordResult=arc4random_uniform(wordInt);
        NSString *word=[self.currentQuestion.words objectAtIndex:wordResult];
        [self.mixQuestionArray addObject:word];
    }
    
    if (self.exceptionSwitch.on)
    {
        if (self.currentQuestion.exceptions.count==0)
        {
        
        }
        else if (self.currentQuestion.exceptions.count>0)
        {
        NSUInteger exceptionArrayCount=self.currentQuestion.exceptions.count;
        int exceptionInt=(int)exceptionArrayCount;
        int exceptionResult=arc4random_uniform(exceptionInt);
        NSString *exception=[self.currentQuestion.exceptions objectAtIndex:exceptionResult];
        [self.mixQuestionArray addObject:exception];
    }
    }
    if (!endSwtichOn && !wordSwitchOn && !exceptionSwitchOn)
    {
        self.correctLabel.text=@"You need to toggle a mode";
    }
  }
    
}

-(void)updateQuestionLabel
{
    [self createQuestionArray];
    
    NSUInteger mixQuestionArrayCount=self.mixQuestionArray.count;
    int newQuestionInt=(int)mixQuestionArrayCount;
    
    if (newQuestionInt>0)
    {
    int newResult=arc4random_uniform(newQuestionInt);
    
    self.questionString=[self.mixQuestionArray objectAtIndex:newResult];
    
    self.questionLabel.text=self.questionString;  
    }

}




- (IBAction)masculinButton:(id)sender {
    
    
    BOOL containsException=[self.currentQuestion.exceptions containsObject:self.questionString];
    BOOL isMasculin = [self.currentQuestion.gender isEqualToString:@"masculin"];
    BOOL isFeminin = [self.currentQuestion.gender isEqualToString:@"feminin"];
    
    
    if (containsException && isMasculin)
    {
         self.correctLabel.text=@"Non! This is an exception!";
      
        
        [self saveAnswerEntryForIncorrect];
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:2];
    }
    if (containsException && isFeminin)
    {
        self.correctLabel.text=@"Oui!!!";
        [self saveAnswerEntryForCorrect];
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
    
    if (!containsException && isMasculin)
    {
        self.correctLabel.text=@"Oui!!!";
        [self saveAnswerEntryForCorrect];
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
    if (!containsException && isFeminin)
    {
        self.correctLabel.text=@"Non!!!";
        [self saveAnswerEntryForIncorrect];
      
         [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
  

}

- (IBAction)femininButton:(id)sender {
    
    BOOL containsException=[self.currentQuestion.exceptions containsObject:self.questionString];
    BOOL isMasculin = [self.currentQuestion.gender isEqualToString:@"masculin"];
    BOOL isFeminin = [self.currentQuestion.gender isEqualToString:@"feminin"];
    
    if (containsException && isFeminin)
    {
        self.correctLabel.text=@"Non! This is an exception!";
        [self saveAnswerEntryForIncorrect];
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:2];
    }
    
    if (containsException && isMasculin)
    {
            self.correctLabel.text=@"Oui!!!";
            [self saveAnswerEntryForCorrect];
            [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
    if (!containsException && isFeminin)
    {
        self.correctLabel.text=@"Oui!!!";
        [self saveAnswerEntryForCorrect];
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
    if (!containsException && isMasculin)
    {
    self.correctLabel.text=@"Non!!!";
        [self saveAnswerEntryForIncorrect];
    [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
}

-(void)resetLabels
{
    self.correctLabel.text=@"";
    [self updateQuestionLabel];
}

-(void)changeQuestionArray:(NSNotification*)notification {
    
    
    Lesson *lesson=notification.userInfo[@"lessonObject"];
    
    BOOL switchState = [notification.userInfo[@"switchState"] boolValue];
    
    if (switchState) {
        for (Question * question in self.allQuestions)
        {
            if ([question.lesson isEqualToString:lesson.name])
            {
                [self.questionArray addObject:question];
            }
        }
    }
    else {
        for (Question* question in self.allQuestions)
        {
            if ([question.lesson isEqualToString:lesson.name])
            {
                [self.questionArray removeObject:question];
                
            }
        }
    }
    NSLog(@"%lu",self.questionArray.count);
}

-(void)saveAnswerEntryForCorrect
{
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext=del.managedObjectContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Answer" inManagedObjectContext:managedObjectContext];
    NSManagedObject *newAnswer = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    
    [newAnswer setValue:self.currentQuestion.ending forKey:@"question"];
    [newAnswer setValue:self.currentQuestion.lesson forKey:@"lesson"];
    [newAnswer setValue:[NSDate date]  forKey:@"date"];
    [newAnswer setValue:@(1) forKey: @"correct"];
    
    [del saveContext];
}

-(void)saveAnswerEntryForIncorrect
{
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext=del.managedObjectContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Answer" inManagedObjectContext:managedObjectContext];
    NSManagedObject *newAnswer = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    
    [newAnswer setValue:self.currentQuestion.ending forKey:@"question"];
    [newAnswer setValue:self.currentQuestion.lesson forKey:@"lesson"];
    [newAnswer setValue:[NSDate date]  forKey:@"date"];
    [newAnswer setValue:@(0) forKey: @"correct"];
    
    
    
    [del saveContext];
}



     




@end

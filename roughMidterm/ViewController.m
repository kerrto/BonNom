//
//  ViewController.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-04.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) NSMutableArray *questionArray;
@property (strong, nonatomic) Question *currentQuestion;
@property (strong, nonatomic) NSString *questionString;
@property (strong, nonatomic) IBOutlet UILabel *correctLabel;

@property (strong, nonatomic) IBOutlet UISwitch *endSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *wordSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *exceptionSwitch;
@property (strong, nonatomic) NSMutableArray *mixQuestionArray;

- (IBAction)masculinButton:(id)sender;
- (IBAction)femininButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadEndingQuestionWithJSON];
    [self updateQuestionLabel];
   
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadEndingQuestionWithJSON {
    NSString *jsonPath =[[NSBundle mainBundle] pathForResource:@"TestJSON" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSError *error = nil;
    NSDictionary *questionDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    self.questionArray=[[NSMutableArray alloc]init];
    if (!error) {
        
        NSArray* endingsObjects = questionDict[@"endings"];
        for (NSDictionary* end in endingsObjects) {
        
            Question *question=[[Question alloc]init];
            
            question.ending=end[@"end"];
            question.lesson=end[@"lesson"];
            question.words=end[@"words"];
            question.exceptions=end[@"exceptions"];
            question.gender=end[@"gender"];
            
            
            [self.questionArray addObject:question];
            
        }
    }
}


-(void)createQuestionArray
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
        else if (self.currentQuestion.exceptions.count>0) {
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

-(void)updateQuestionLabel {
    [self createQuestionArray];
    
    NSUInteger mixQuestionArrayCount=self.mixQuestionArray.count;
    int newQuestionInt=(int)mixQuestionArrayCount;
    
    if (newQuestionInt>0) {
    int newResult=arc4random_uniform(newQuestionInt);
    
    self.questionString=[self.mixQuestionArray objectAtIndex:newResult];
    
    self.questionLabel.text=self.questionString;  
    }

}




- (IBAction)masculinButton:(id)sender {
    
    
    BOOL containsException=[self.currentQuestion.exceptions containsObject:self.questionString];
    BOOL isMasculin = [self.currentQuestion.gender isEqualToString:@"masculin"];
    BOOL isFeminin = [self.currentQuestion.gender isEqualToString:@"feminin"];
    
    
    if (containsException && isMasculin) {
         self.correctLabel.text=@"Non! This is an exception! It's feminin";
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:2];
    }
    if (containsException && isFeminin)
    {
        self.correctLabel.text=@"Oui!!!";
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
    
    if (!containsException && isMasculin)
    {
        self.correctLabel.text=@"Oui!!!";
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
    if (!containsException && isFeminin) {
        self.correctLabel.text=@"Non!!!";
         [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
  

}

- (IBAction)femininButton:(id)sender {
    
    BOOL containsException=[self.currentQuestion.exceptions containsObject:self.questionString];
    BOOL isMasculin = [self.currentQuestion.gender isEqualToString:@"masculin"];
    BOOL isFeminin = [self.currentQuestion.gender isEqualToString:@"feminin"];
    
    if (containsException && isFeminin)
    {
        self.correctLabel.text=@"Non! This is an exception! It's masculin";
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:2];
    }
    
    if (containsException && isMasculin)
        {
            self.correctLabel.text=@"Oui!!!";
            [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
        }
    if (!containsException && isFeminin)
    {
        self.correctLabel.text=@"Oui!!!";
        [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
    if (!containsException && isMasculin)
    {
    self.correctLabel.text=@"Non!!!";
    [self performSelector:@selector(resetLabels) withObject:nil afterDelay:1];
    }
}

-(void)resetLabels {
    self.correctLabel.text=@"";
    [self updateQuestionLabel];
}




@end

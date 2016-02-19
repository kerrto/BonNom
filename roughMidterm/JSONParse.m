//
//  JSONParse.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-09.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "JSONParse.h"
#import "Question.h"
#import "Lesson.h"



@implementation JSONParse

-(instancetype)init {
    self=[super init];
    if (self) {
        _lessonsArray=[[NSMutableArray alloc]init];
        _questions=[[NSMutableArray alloc]init];
    }
    return self;
}


-(void)loadEndingQuestionWithJSON
{
    NSString *jsonPath =[[NSBundle mainBundle] pathForResource:@"TestJSON" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSError *error = nil;
    NSDictionary *questionDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    self.questions=[[NSMutableArray alloc]init];
    self.lessonsArray=[[NSMutableArray alloc]init];
    if (!error)
    {
        
        NSArray *lessonsObjects = questionDict[@"lessons"];
        for (NSDictionary* lessonDictionary in lessonsObjects)
        {
            Lesson *currentLesson = [[Lesson alloc] init];
            
            currentLesson.name = lessonDictionary[@"name"];
            currentLesson.masculin= [[NSMutableArray alloc]init];
            currentLesson.feminin=[[NSMutableArray alloc]init];

         
            
            NSArray *questionsArray = lessonDictionary[@"questions"];
            for (NSDictionary *questionDictionary in questionsArray) {
                Question *question = [[Question alloc]init];
                
                question.ending = questionDictionary[@"end"];
                question.words = questionDictionary[@"words"];
                question.exceptions = questionDictionary[@"exceptions"];
                question.gender = questionDictionary[@"gender"];
                question.lesson= questionDictionary[@"lesson"];
                [self.questions addObject:question];
                
                if ([question.gender isEqualToString:@"masculin"])
                {
                    [currentLesson.masculin addObject:question.ending];
                }
                if ([question.gender isEqualToString:@"feminin"])
                {
                    [currentLesson.feminin addObject:question.ending];}
                }
            
          
            [self.lessonsArray addObject:currentLesson];
        }

        
        }
    
 
    }






@end

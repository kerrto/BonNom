//
//  QuestionArray.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-10.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "QuestionArray.h"
#import "Question.h"
#import "LessonTableViewCell.h"

@implementation QuestionArray

-(instancetype)init {
    self=[super init];
    if (self) {
        _changedQuestionArray=[[NSMutableArray alloc]init];
    }
    return self;
}


//-(void) changeQuestionArray {
//    JSONParse *json=[[JSONParse alloc]init];
//    [json loadEndingQuestionWithJSON];
//    Question *question=[[Question alloc]init];
//    LessonTableViewCell *cell=[[]
//    
//    if (
//    
//    json.questions;
//}

@end

//
//  JSONParse.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-09.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParse : NSObject

@property (nonatomic, strong)NSMutableArray *lessonsArray;
@property (nonatomic, strong)NSMutableArray *questions;

-(void)loadEndingQuestionWithJSON;

@end

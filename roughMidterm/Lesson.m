//
//  Lesson.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-09.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "Lesson.h"

@implementation Lesson

- (instancetype)init
{
    self = [super init];
    if (self) {
        _feminin = [[NSMutableArray alloc] init];
        _masculin = [[NSMutableArray alloc] init];
        _questions = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

//
//  Question.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-08.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, strong) NSString *gender;

@property (nonatomic, strong) NSArray *exceptions;

@property (nonatomic, strong) NSArray *words;

@property (nonatomic, strong) NSString *ending;

@end

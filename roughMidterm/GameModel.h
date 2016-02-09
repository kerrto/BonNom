//
//  GameModel.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-08.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (nonatomic, strong) NSString *questionString;

@property (nonatomic, strong) NSString *answerString;

@property (nonatomic, strong) NSString *correctionString;

@end

//
//  Answer+CoreDataProperties.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-10.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Answer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Answer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *question;
@property (nullable, nonatomic, retain) NSString *lesson;
@property (nullable, nonatomic, retain) NSNumber *correct;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END

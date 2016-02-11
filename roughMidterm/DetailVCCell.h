//
//  DetailVCCell.h
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-11.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVCCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *endingLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UITextView *wordsLabel;
@property (strong, nonatomic) IBOutlet UITextView *exceptionsLabel;

@end

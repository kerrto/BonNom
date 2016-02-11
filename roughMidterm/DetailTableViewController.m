//
//  DetailTableViewController.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-11.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "DetailTableViewController.h"
#import "JSONParse.h"
#import "Question.h"
#import "Lesson.h"
#import "DetailVCCell.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findQuestionsForLesson];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.questionsInLesson.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Question *cellQuestion=self.questionsInLesson[indexPath.row];
    
    
    
    cell.endingLabel.text = cellQuestion.ending;
    cell.genderLabel.text = cellQuestion.gender;
    
    NSString *wordsString = [cellQuestion.words componentsJoinedByString:@","];
    
    cell.wordsLabel.text=wordsString;
    
     NSString *exceptionsString = [cellQuestion.exceptions componentsJoinedByString:@","];
    
    
    cell.exceptionsLabel.text = exceptionsString;

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)findQuestionsForLesson
{
    JSONParse *json=[[JSONParse alloc]init];
    [json loadEndingQuestionWithJSON];
    //    Question *questionUp=[[Question alloc]init];
    self.questionsInLesson=[[NSMutableArray alloc]init];
    
    for (Question *question in json.questions)
    {

        if ([question.lesson isEqualToString:self.lesson.name]) {
            [self.questionsInLesson addObject:question];
        }
        
    }
}
@end

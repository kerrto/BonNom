//
//  LessonTableViewController.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-09.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "LessonTableViewController.h"
#import "LessonTableViewCell.h"
#import "Question.h"
#import "Lesson.h"
#import "JSONParse.h"
#import "ViewController.h"
#import "DetailTableViewController.h"

@interface LessonTableViewController ()

@property (nonatomic, strong) LessonTableViewCell *cell;

@end

@implementation LessonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JSONParse *json=[[JSONParse alloc]init];
    [json loadEndingQuestionWithJSON];
    self.lessonArray=json.lessonsArray;
 
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lessonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Lesson *lesson=self.lessonArray[indexPath.row];    
    self.cell.lessonObject = lesson;
    
    return self.cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewController *dtvc = (DetailTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailTableViewController"];
    
    dtvc.lesson = self.cell.lessonObject;
    [self.navigationController pushViewController:dtvc animated:true];
}

@end

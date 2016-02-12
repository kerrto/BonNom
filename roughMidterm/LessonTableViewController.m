//
//  LessonTableViewController.m
//  roughMidterm
//
//  Created by Kerry Toonen on 2016-02-09.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//
#import <ChameleonFramework/Chameleon.h>
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
 
    NSArray *colors = @[[UIColor flatSkyBlueColor], [UIColor flatSkyBlueColorDark]];
    
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:self.view.frame andColors:colors];
    
    self.title = @"Lessons";
    self.tabBarItem.image = [UIImage imageNamed:@"blackboard.png"];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *colors = @[[UIColor flatSkyBlueColor], [UIColor flatSkyBlueColorDark]];
    
    cell.contentView.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:cell.frame andColors:colors];
    
}

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

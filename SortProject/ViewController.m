//
//  ViewController.m
//  Test
//
//  Created by Xiong on 2018/1/29.
//  Copyright © 2018年 Xiong. All rights reserved.
//

#import "ViewController.h"
#import "SortView.h"
#import "SortClass.h"

@interface ViewController ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (weak, nonatomic) IBOutlet UITextField *textField;



@property (strong, nonatomic) NSMutableArray *sortViewHeightArray;
@property (strong, nonatomic) NSMutableArray *sortViewsArray;
@property (nonatomic, assign) NSInteger num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.num = self.textField.text.integerValue;
    
    [self configSortViewHeight];
    [self addSortView];
    
    
}


- (void)configSortViewHeight
{
    [self.sortViewHeightArray removeAllObjects];
    self.sortViewHeightArray = [NSMutableArray array];
    for (int i = 0; i < self.num; i++) {
        [self.sortViewHeightArray addObject:@(arc4random_uniform((uint32_t)self.displayView.frame.size.height))];
    }
}

- (void)addSortView
{
    self.sortViewsArray = [NSMutableArray array];
    [self.sortViewHeightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGSize size = CGSizeMake(self.view.frame.size.width/self.num, [obj integerValue]);
        CGPoint point = CGPointMake(idx * self.view.frame.size.width/self.num, 0);
        
        SortView *sortView = [[SortView alloc]initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
        [self.displayView addSubview:sortView];
        [self.sortViewsArray addObject:sortView];
    }];
}


- (IBAction)changeSortType:(UISegmentedControl *)sender {
    
    [self reset:nil];
}

- (IBAction)startSort:(id)sender
{
    [self.view endEditing:YES];
    SortType sortType = self.segmentedControl.selectedSegmentIndex + 1;
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [SortClass sortWithType:sortType array:self.sortViewHeightArray handleBlock:^(NSInteger index, NSInteger height) {
            __strong typeof(self)strongSelf = weakSelf;
            [strongSelf updateSortViewAtIndex:index withHeight:height];
        }];
    });
}

- (IBAction)reset:(id)sender
{
    [self.view endEditing:YES];
    [self.displayView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj removeFromSuperview];
    }];
    self.num = self.textField.text.integerValue;                                
    [self.sortViewHeightArray removeAllObjects];
    [self configSortViewHeight];
    [self addSortView];
}

- (void)updateSortViewAtIndex:(NSInteger)index withHeight:(NSInteger)height
{
    dispatch_async(dispatch_get_main_queue(), ^{
        SortView *view = self.sortViewsArray[index];
        [view updateSortViewWithHeight:height];
    });
    [NSThread sleepForTimeInterval:0.0001];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.num = self.textField.text.integerValue;
    [self.view endEditing:YES];
}
@end

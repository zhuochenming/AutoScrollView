//
//  ViewController.m
//  AutoScrollView
//
//  Created by boleketang on 16/2/26.
//  Copyright © 2016年 zhuochenming. All rights reserved.
//

#import "ViewController.h"
#import "AutoScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AutoScrollView *scrollView = [[AutoScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(0, 0);
    
    UITextField *textFieldOne=[[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 50)];
    textFieldOne.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:textFieldOne];
    
    UITextField *textFieldTwo=[[UITextField alloc] initWithFrame:CGRectMake(10, 400, 300, 50)];
    textFieldTwo.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:textFieldTwo];
    
    UITextField *textFieldThree=[[UITextField alloc] initWithFrame:CGRectMake(10, 500, 300, 50)];
    textFieldThree.backgroundColor=[UIColor orangeColor];
    [scrollView addSubview:textFieldThree];
    
    [self.view addSubview:scrollView];

    [scrollView autoContentSize];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

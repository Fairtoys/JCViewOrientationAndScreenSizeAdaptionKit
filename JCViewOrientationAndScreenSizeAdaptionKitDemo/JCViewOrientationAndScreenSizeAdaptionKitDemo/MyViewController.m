//
//  MyViewController.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/4.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "MyViewController.h"
#import "JCPopupUtils.h"
#import "MyViewController1.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickBtn:(id)sender {
    MyViewController1 *vc = [[MyViewController1 alloc] init];
    [self.parentViewController poputils_hideLastViewAndShowController:vc];
}
- (IBAction)onClickShowView:(id)sender {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor cyanColor];
    [self.parentViewController.view poputils_hideLastViewAndShowView:view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc{
    NSLog(@"dealloc:%@", self);
}
@end

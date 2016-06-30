//
//  ViewController.m
//  KeyBoardToolBar
//
//  Created by PengFan on 16/6/28.
//  Copyright © 2016年 PengFan. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardTool.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)KeyboardTool *tool;

@end

@implementation ViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:_tool name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tool = [[KeyboardTool alloc] init];
    _tool.fieldArray = @[_textField1,_textField2,_textField3];
    [self.view addSubview:_tool.toolBar];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [_tool showToolBar:textField];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

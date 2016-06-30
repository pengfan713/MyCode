//
//  KeyboardTool.m
//  KeyBoardToolBar
//
//  Created by PengFan on 16/6/28.
//  Copyright © 2016年 PengFan. All rights reserved.
//

#import "KeyboardTool.h"

@interface KeyboardTool()

@property (nonatomic, strong)UITextField *currentField;

@end

@implementation KeyboardTool

-(instancetype)init
{
    if (self == [super init])
    {
        
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 44)];
        
        
        UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:(UIBarButtonItemStylePlain) target:self action:@selector(showNext)];
        UIBarButtonItem *previousItem = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:(UIBarButtonItemStylePlain) target:self action:@selector(showPrevious)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏" style:(UIBarButtonItemStylePlain) target:self action:@selector(showHide)];
        
        _toolBar.items = @[nextItem,previousItem,spaceItem,doneItem];
        
        ///监听键盘高度变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillShowNotification object:nil];
        
        _currentField =  nil;
        
    }
    return self;
}

-(void)showNext {
    
    NSInteger current = [_fieldArray indexOfObject:_currentField];
    
    if ((current + 1) < _fieldArray.count)
    {
        UITextField *field = [_fieldArray objectAtIndex:current + 1];
        [field becomeFirstResponder];
    }
}

-(void)showPrevious {
    
    NSInteger current = [_fieldArray indexOfObject:_currentField];
    
    if ((current - 1) >= 0)
    {
        UITextField *field = [_fieldArray objectAtIndex:current - 1];
        [field becomeFirstResponder];
    }
}

-(void)showHide {
    
    NSInteger current = [_fieldArray indexOfObject:_currentField];
    UITextField *field = [_fieldArray objectAtIndex:current];
    [field resignFirstResponder];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    [_toolBar setFrame:CGRectMake(0, screenHeight, screenWidth, 44)];
}

-(void)keyboardFrameChange:(NSNotification*)notify {
    
    CGRect frame = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;

    [UIView animateWithDuration:0.1 animations:^{
        
        ///键盘高度更改
        [_toolBar setFrame:CGRectMake(0, frame.origin.y - 44 , screenWidth, 44)];
        
    }];
}

//显示键盘
-(void)showToolBar:(UITextField *)field
{
    _currentField = field;
}

@end

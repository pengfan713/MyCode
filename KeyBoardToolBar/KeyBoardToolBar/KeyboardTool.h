//
//  KeyboardTool.h
//  KeyBoardToolBar
//
//  Created by PengFan on 16/6/28.
//  Copyright © 2016年 PengFan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KeyboardTool : NSObject

///用于界面展示的toolbar
@property (nonatomic,strong) UIToolbar *toolBar;
///用于光标切换的数组
@property (nonatomic,strong) NSArray *fieldArray;

///显示键盘
-(void)showToolBar:(UITextField *)field;

@end

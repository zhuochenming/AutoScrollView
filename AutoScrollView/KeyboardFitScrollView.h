//
//  KeyboardFitScrollView.h
//  KeyboardFitScrollView
//
//  Created by Zhuochenming on 16/2/26.
//  Copyright © 2016年 Zhuochenming. All rights reserved.
//

/*
 
 使用KeyboardFitScrollView
 
 1.继承于KeyboardFitScrollView
 
 2.KeyboardFitScrollView自带点击自身隐藏键盘功能
 
 3.在设置完KeyboardFitScrollView的子控件后调用autoContentSize
 
*/

#import <UIKit/UIKit.h>

//ScrollView最后一个控件距离底部的距离
static CGFloat const KeyboardFitBottomHeight = 20.0;
//键盘高度
static CGFloat const KeyboardFitKeyBoardHeight = 285.0;



@interface KeyboardFitScrollView : UIScrollView

- (void)autoContentSizeWithLastView:(UIView *)view isNeedPopkeybouard:(BOOL)need;

@end

//
//  KeyboardFitScrollView.m
//  KeyboardFitScrollView
//
//  Created by Zhuochenming on 16/2/26.
//  Copyright © 2016年 Zhuochenming. All rights reserved.
//

#import "KeyboardFitScrollView.h"

@interface KeyboardFitScrollView ()

@property (nonatomic, assign) CGSize originalContentSize;

@property (nonatomic, assign) CGFloat maxContentSizeHeight;

@end

@implementation KeyboardFitScrollView

#pragma mark - 注册键盘通知
- (void)autoContentSizeWithLastView:(UIView *)view isNeedPopkeybouard:(BOOL)need {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTap)];
    [self addGestureRecognizer:tap];

    if (need) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    
//    [self countContentMaxHeight:self];
    CGRect convertRect = [view convertRect:view.bounds toView:self];
    self.maxContentSizeHeight = CGRectGetMaxY(convertRect);
    
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), _maxContentSizeHeight + KeyboardFitBottomHeight);
    self.originalContentSize = self.contentSize;
    
    self.maxContentSizeHeight = self.maxContentSizeHeight + KeyboardFitKeyBoardHeight + KeyboardFitBottomHeight;
}

//- (void)countContentMaxHeight:(UIView *)parentView {
//    [parentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIView *view = obj;
//        if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
//            CGRect convertRect = [view convertRect:view.bounds toView:self];
//            CGFloat y = CGRectGetMaxY(convertRect);
//            if (y > self.maxContentSizeHeight) {
//                self.maxContentSizeHeight = y;
//            }
//        }
//        NSLog(@"%f", self.maxContentSizeHeight);
//        if (view.subviews.count > 0) {
//            [self countContentMaxHeight:view];
//        }
//    }];
//}

#pragma mark - 手势事件
- (void)scrollViewTap {
    [self setContentOffset:CGPointZero animated:YES];
    [self endEditing:YES];
}

#pragma mark - 键盘事件
- (void)keyboardWillShow:(NSNotification *)aNotification {
    [self enumerateSubViews:self];
}

- (void)keyboardWillHidden:(NSNotification *)aNotification {
    self.contentSize = _originalContentSize;
}

- (void)enumerateSubViews:(UIView *)parentViews {
    [parentViews.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        if (view.isFirstResponder) {
            CGFloat heightOfFrame = CGRectGetHeight(self.frame);
            CGRect convertRect = [view convertRect:view.bounds toView:self];
            
            CGFloat marginBottom = heightOfFrame - (CGRectGetMaxY(convertRect) - self.contentOffset.y);

            if (marginBottom < KeyboardFitKeyBoardHeight) {
                CGFloat viewMarginBottom = heightOfFrame - (convertRect.origin.y + convertRect.size.height);
                CGFloat originY = KeyboardFitKeyBoardHeight - viewMarginBottom;
                [self setContentOffset:CGPointMake(self.frame.origin.x, originY) animated:YES];
            }
            return;
        }
        if (view.subviews.count > 0) {
            [self enumerateSubViews:view];
        }
    }];
}

#pragma mark - 移除通知
- (void)dealloc {
    [self endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

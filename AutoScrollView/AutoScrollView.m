//
//  AutoScrollView.m
//  AutoScrollView
//
//  Created by boleketang on 16/2/26.
//  Copyright © 2016年 zhuochenming. All rights reserved.
//

#import "AutoScrollView.h"
//ScrollView最后一个控件距离底部的距离
#define ZBottomHeight 20
#define kKeyBoardHeight 285 

@interface AutoScrollView ()

@property (nonatomic, assign) CGSize srcContentSize;

@property (nonatomic, assign) CGFloat maxContentSizeHeight;

@end

@implementation AutoScrollView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [self autoContentSize];
}

- (void)autoContentSize {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.srcContentSize = self.contentSize;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTap)];
    [self addGestureRecognizer:tap];
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self countContentMaxHeight:self];
    self.maxContentSizeHeight = self.maxContentSizeHeight + kKeyBoardHeight + ZBottomHeight;
}

- (void)countContentMaxHeight:(UIView*)parentView {
    [parentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
            CGRect convertRect = [view convertRect:view.bounds toView:self];
            CGFloat y = convertRect.size.height + convertRect.origin.y;
            if (y > self.maxContentSizeHeight) {
                self.maxContentSizeHeight = y;
            }
        }
        if (view.subviews.count > 0) {
            [self countContentMaxHeight:view];
        }
    }];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.srcContentSize = frame.size;
}

#pragma mark - 手势事件
- (void)scrollViewTap {
    [self endEditing:YES];
}

#pragma mark - 键盘事件
- (void)keyboardWillHidden:(NSNotification *)aNotification {
    self.contentSize = _srcContentSize;
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    [self enumerateSubViews:self];
}

- (void)enumerateSubViews:(UIView *)parentViews {
    [parentViews.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        if (view.isFirstResponder) {
            CGRect convertRect = [view convertRect:view.bounds toView:self];
            CGFloat marginBottom = self.frame.size.height - (convertRect.origin.y + convertRect.size.height - self.contentOffset.y);
            
            if (self.contentSize.height < self.maxContentSizeHeight) {
                self.contentSize = CGSizeMake(self.contentSize.width, self.maxContentSizeHeight);
            }
            if (marginBottom < kKeyBoardHeight) {
                CGFloat marginBottom = self.frame.size.height - (convertRect.origin.y + convertRect.size.height);
                CGFloat originY = kKeyBoardHeight - marginBottom;
                [self setContentOffset:CGPointMake(self.frame.origin.x, originY) animated:YES];
            }
            return;
        }
        if (view.subviews.count > 0) {
            [self enumerateSubViews:view];
        }
    }];
}


@end

//
//  TagView.m
//  TagVIew
//
//  Created by adai on 2018/8/23.
//  Copyright © 2018年 adai. All rights reserved.
//

#import "TagView.h"
#import "UIView+Frame.h"
#import "TagButton.h"

#define margin 10
#define SWidth [UIScreen mainScreen].bounds.size.width
#define SHeight [UIScreen mainScreen].bounds.size.height

@interface TagView ()

@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation TagView

#pragma mark - Actions
/** 添加标签名 */
- (void)addTagTitle:(NSString *)tagTitle {
    // 创建添加button
    [self createAddButtonWithTitle:tagTitle];
    
    // 更新frame
    [self updateButtonsFrame];
    
    // 更新回调
    if (self.updateViewHeightForAdd) {
        self.updateViewHeightForAdd();
    }
}

/** 删除button */
- (void)deleteButtonAction:(UIButton *)button {
    [button removeFromSuperview];
    [self.tagButtons removeObject:button];
    
    // 更新frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateButtonsFrame];
    }];
    
    // 更新回调
    if (self.updateViewHeightForDelete) {
        self.updateViewHeightForDelete();
    }
}

/** 更新button的frame */
- (void)updateButtonsFrame {
    for (NSInteger i = 0; i < self.tagButtons.count; i++) {
        TagButton *button = self.tagButtons[i];
        if (i == 0) { // 第一个
            button.x = margin;
            button.y = margin;
        } else {
            TagButton *lastButton = self.tagButtons[i - 1];
            // 当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + margin;
            // 当前行右边的宽度
            CGFloat rightWidth = SWidth - leftWidth;
            if (rightWidth >= button.width) {
                button.x = leftWidth;
                button.y = lastButton.y;
            } else {
                button.x = margin;
                button.y = CGRectGetMaxY(lastButton.frame) + margin;
            }
        }
    }
}

/** 获取高度 */
- (CGFloat)tagViewHeight {
    if (self.tagButtons.count == 0) return 0;
    
    TagButton *button = self.tagButtons.lastObject;
    return CGRectGetMaxY(button.frame) + margin;
}

#pragma mark - init
/** 创建添加button */
- (void)createAddButtonWithTitle:(NSString *)title {
    TagButton *button = [TagButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(deleteButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.tagButtons addObject:button];
    [self addSubview:button];
}

#pragma mark - Setter
- (void)setTagTitles:(NSArray *)tagTitles {
    _tagTitles = tagTitles;

    for (NSString *title in _tagTitles) {
        [self createAddButtonWithTitle:title];
    }
    [self updateButtonsFrame];
}

#pragma mark - Lazy
- (NSMutableArray *)tagButtons {
    if (_tagButtons == nil) {
        _tagButtons = [[NSMutableArray alloc] init];
    }
    return _tagButtons;
}

@end

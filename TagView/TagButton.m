//
//  TagButton.m
//  TagVIew
//
//  Created by adai on 2018/8/23.
//  Copyright © 2018年 adai. All rights reserved.
//

/** 自定义间隔 */
#define margin 5
/** 自定义高度 */
#define tagBtnHeight 30

#import "TagButton.h"
#import "UIView+Frame.h"

@implementation TagButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 自定义button的相关属性
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/** 根据title确认宽度 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    // 自动确认宽度
    [self sizeToFit];
    
    // 设置宽度和高度
    self.width += margin * 2;
    self.height = tagBtnHeight;
    
    // 更新frame
    [self layoutIfNeeded];
}

/** 更换image和title的位置 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // title.x替换为imageView.x
    self.titleLabel.x = self.imageView.x;
    // imageView.x相应后置
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + margin;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, margin);
}

@end

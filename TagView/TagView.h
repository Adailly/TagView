//
//  TagView.h
//  TagVIew
//
//  Created by adai on 2018/8/23.
//  Copyright © 2018年 adai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView

/** 设置标签 */
@property (nonatomic, strong) NSArray *tagTitles;
/** 删除回调 */
@property (nonatomic, copy) void (^updateViewHeightForDelete)(void);
/** 添加回调 */
@property (nonatomic, copy) void (^updateViewHeightForAdd)(void);

/** 添加标签名 */
- (void)addTagTitle:(NSString *)tagTitle;

/** 获取tagView的高度 */
- (CGFloat)tagViewHeight;

@end

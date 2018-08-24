//
//  ViewController.m
//  TagVIew
//
//  Created by adai on 2018/8/23.
//  Copyright © 2018年 adai. All rights reserved.
//

#import "ViewController.h"
#import "TagView.h"
#import "UIView+Frame.h"

#define SWidth [UIScreen mainScreen].bounds.size.width
#define SHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) TagView *tagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"孙悟空", @"克林", @"比克叔叔", @"悟饭", @"那美克星", @"贝吉塔"];
    [self.view addSubview:self.scrollView];
    
    self.tagView = [[TagView alloc] init];
    self.tagView.tagTitles = self.titles;
    self.tagView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self.tagView];
    
    // 初始设置
    CGFloat height = [self.tagView tagViewHeight];
    CGRect tagFrame = CGRectMake(0, 0, SWidth, height);
    self.tagView.frame = tagFrame;
    self.scrollView.frame = CGRectMake(0, 20, SWidth, height >= 170 ? 170 : height);
    self.scrollView.contentSize = CGSizeMake(0, height);
    
    // 更新frame
    [self updateTagViewFrameForDelete];
}

- (IBAction)addTag:(UIButton *)button {
    NSInteger index = arc4random() % self.titles.count;
    [self.tagView addTagTitle:self.titles[index]];
    [self updateTagViewFrameForAdd];
}

- (void)updateTagViewFrameForAdd {
    __weak typeof(self)weakSelf = self;
    self.tagView.updateViewHeightForAdd = ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CGFloat height = [strongSelf.tagView tagViewHeight];
        CGRect tagFrame = CGRectMake(0, 0, SWidth, height);
        strongSelf.tagView.frame = tagFrame;
        // scrollview： frame size
        strongSelf.scrollView.frame = CGRectMake(0, 20, SWidth, height >= 170 ? 170 : height);
        strongSelf.scrollView.contentSize = CGSizeMake(0, height);
        // 滚动到最底部
        if (height > 170) {
            [strongSelf.scrollView setContentOffset:CGPointMake(0, height - 170) animated:YES];
        }
    };
}

- (void)updateTagViewFrameForDelete {
    __weak typeof(self)weakSelf = self;
    self.tagView.updateViewHeightForDelete = ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CGFloat height = [strongSelf.tagView tagViewHeight];
        CGRect tagFrame = CGRectMake(0, 0, SWidth, height);
        strongSelf.tagView.frame = tagFrame;
        // scrollview： frame size
        strongSelf.scrollView.frame = CGRectMake(0, 20, SWidth, height >= 170 ? 170 : height);
        strongSelf.scrollView.contentSize = CGSizeMake(0, height);
    };
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

@end

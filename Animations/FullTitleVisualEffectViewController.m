//
//  FullTitleVisualEffectViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "FullTitleVisualEffectViewController.h"
#import "UIView+SetRect.h"
#import "UIColor+CustomColors.h"

@interface FullTitleVisualEffectViewController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;

@end

@implementation FullTitleVisualEffectViewController

- (void)buildTitleView {

    [super buildTitleView];
    
    // 添加模糊效果
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.effectView.userInteractionEnabled = NO;
    self.effectView.frame                  = self.titleView.bounds;
    self.effectView.userInteractionEnabled = YES;
    [self.titleView addSubview:self.effectView];
    
    // 需要与作用的effectView的效果一致
    _vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)self.effectView.effect]];
    _vibrancyEffectView.frame = self.effectView.bounds;
    [self.effectView.contentView addSubview:self.vibrancyEffectView];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconTypeTwo"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, self.titleView.middleY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = Font_Heiti(20.f);
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor customGrayColor];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    headlinelabel.center        = self.titleView.middlePoint;
    [_vibrancyEffectView.contentView addSubview:backButton];
    [_vibrancyEffectView.contentView addSubview:headlinelabel];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end

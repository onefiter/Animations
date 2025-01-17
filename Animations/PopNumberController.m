//
//  PopNumberController.m
//  Animations
//
//  Created by YouXianMing on 15/11/18.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "PopNumberController.h"
#import "POPNumberAnimation.h"
#import "GCD.h"
#import "StringAttributeHelper.h"
#import "UIView+SetRect.h"

@interface PopNumberController () <POPNumberAnimationDelegate>

@property (nonatomic, strong) POPNumberAnimation *numberAnimation;
@property (nonatomic, strong) GCDTimer           *timer;
@property (nonatomic, strong) UILabel            *label;

@end

@implementation PopNumberController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setup {

    [super setup];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.center        = self.contentView.middlePoint;
    [self.contentView addSubview:_label];
    
    // Init numberAnimation.
    self.numberAnimation          = [[POPNumberAnimation alloc] init];
    self.numberAnimation.delegate = self;
    
    // Timer event.
    __weak PopNumberController *weakSelf = self;
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        // Start animation.
        [weakSelf configNumberAnimation];
        [weakSelf.numberAnimation startAnimation];
        
    } timeIntervalWithSecs:3.f];
    [self.timer start];
}

- (void)configNumberAnimation {

    self.numberAnimation.fromValue      = self.numberAnimation.currentValue;
    self.numberAnimation.toValue        = (arc4random() % 101 / 1.f);
    self.numberAnimation.duration       = 2.f;
    self.numberAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    [self.numberAnimation saveValues];
}

- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue {
    
    // Init string.
    NSString *numberString = [NSString stringWithFormat:@"%.1f", currentValue];
    NSString *mpsString    = @"mps";
    NSString *totalString  = [NSString stringWithFormat:@"%@ %@", numberString, mpsString];
    
    // Init string ranges.
    NSRange   mpsRange     = [totalString rangeOfString:mpsString];
    NSRange   numberRange  = [totalString rangeOfString:numberString];
    NSRange   totalRange   = NSMakeRange(0, totalString.length);
    
    // Init attributes.
    FontAttribute *totalFont = [FontAttribute new];
    totalFont.font           = Font_Avenir_Light(20.f);
    totalFont.effectRange    = totalRange;
    
    FontAttribute *numberFont = [FontAttribute new];
    numberFont.font           = Font_HYQiHei(60.f);
    numberFont.effectRange    = numberRange;
    
    ForegroundColorAttribute *totalColor = [ForegroundColorAttribute new];
    totalColor.color                     = [UIColor blackColor];
    totalColor.effectRange               = totalRange;

    ForegroundColorAttribute *mpsColor   = [ForegroundColorAttribute new];
    mpsColor.color                       = [self mpsColorWithValue:currentValue / 100.f];
    mpsColor.effectRange                 = mpsRange;
    
    ForegroundColorAttribute *numColor   = [ForegroundColorAttribute new];
    numColor.color                       = [self numColorWithValue:currentValue / 100.f];
    numColor.effectRange                 = numberRange;
    
    // Create richString.
    NSMutableAttributedString *richString = [[NSMutableAttributedString alloc] initWithString:totalString];
    [richString addStringAttribute:totalFont];
    [richString addStringAttribute:totalColor];
    [richString addStringAttribute:numberFont];
    [richString addStringAttribute:mpsColor];
    [richString addStringAttribute:numColor];
    
    _label.attributedText = richString;
}

- (UIColor *)numColorWithValue:(CGFloat)value {

    return [UIColor colorWithRed:value green:0 blue:0 alpha:1.f];
}

- (UIColor *)mpsColorWithValue:(CGFloat)value {
    
    return [UIColor colorWithRed:0 green:value / 2.f blue:value / 3.f alpha:value];
}

@end

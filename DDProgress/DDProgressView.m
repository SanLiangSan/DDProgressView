/*
 * DDProgressView https://github.com/SanLiangSan/DDProgressView
 *
 * Copyright (c) 2014 SanLiangSan
 *
 * This is a custom progressView which can layout the progress colorful
 *
 * This project is public for every one!
 *
 * If you have any question, please give me a email.
 * Author: SanLiangSan
 * Email: 254458886@qq.com
 *
 */

#import "DDProgressView.h"

@interface DDProgressView()

@property (nonatomic, strong) CAGradientLayer *progressLayer;

@property (nonatomic) float progressDuration;

@property (nonatomic) CGFloat progressViewWidth;

@property (nonatomic) CGFloat progressViewHeight;

@property (nonatomic) CALayer *remainMask;// 遮罩

@property (nonatomic) BOOL colofulIng;

@end

// -----------------------------------------------------------------------
static float defaultProgressAnimationTime = 0.25f;

static float colorChangeTime = 0.08f;

#define kDefaultMaskColor [UIColor blackColor]
// -----------------------------------------------------------------------

@implementation DDProgressView

- (id)initWithFrame:(CGRect)frame backGroundColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        _colofulIng = YES;
        _progressViewWidth = CGRectGetWidth(frame);
        _progressViewHeight = CGRectGetHeight(frame);
        _progressDuration = defaultProgressAnimationTime;
        _progress = 0.0f;
        [self addLayer];
    }
    return self;
}

- (void)setProgress:(float)aProgress {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progress = MIN(1, aProgress);
        _progressDuration = defaultProgressAnimationTime;
        [self setNeedsLayout];
    });
}

- (void)setProgress:(float)progress duation:(float)seconds animated:(BOOL)animated {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressDuration = seconds;
        _progress = MIN(1, progress);
        [self setNeedsLayout];
    });
}

- (void) addLayer {
    // colorful layer
    _progressLayer = [self gradientLayer];
    _progressLayer.frame = (CGRect){0,0,_progressViewWidth,_progressViewHeight};
    [self.layer addSublayer:_progressLayer];
    [self performAnimation];
    // mask layer
    _remainMask = [CALayer layer];
    _remainMask.frame = (CGRect){0,0,0,_progressViewHeight};
    _remainMask.backgroundColor = [UIColor blackColor].CGColor;
    _progressLayer.mask = _remainMask;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setAnimationDuration:_progressDuration];
    CGRect maskRect = _remainMask.frame;
    maskRect.size.width = CGRectGetWidth(self.bounds)*_progress;
    _remainMask.frame = maskRect;
    [CATransaction commit];
}


// -----------------------------------------------------------------------
#pragma mark - Layer
// -----------------------------------------------------------------------
/* CAGradientLayer */
- (CAGradientLayer *)gradientLayer {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.anchorPoint = (CGPoint){0,0.5};
    layer.startPoint = (CGPoint){0,0.5};
    layer.endPoint = (CGPoint){1.0,0.5};
    // Create colors using hues in +5 increments
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger hue = 0; hue <= 360; hue += 5) {
        UIColor *color;
        color = [UIColor colorWithHue:1.0 * hue / 360.0
                           saturation:1.0
                           brightness:1.0
                                alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    layer.colors = colors;
    return layer;
}


// -----------------------------------------------------------------------
#pragma mark - Animation
// -----------------------------------------------------------------------

- (void)performAnimation {
    // animation
    NSMutableArray *mutable = _progressLayer.colors.mutableCopy;
    id lastColor = mutable.lastObject;
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];
    NSArray *shiftedColors = [NSArray arrayWithArray:mutable];
    
    // update the colors
    _progressLayer.colors = shiftedColors;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.toValue = shiftedColors;
    animation.duration = colorChangeTime;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [_progressLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_colofulIng) {
        [self performAnimation];
    }
}


// -----------------------------------------------------------------------
#pragma mark - colorful
// -----------------------------------------------------------------------

- (void) startColorful {
    _colofulIng = YES;
    [self performAnimation];
}

- (void) stopColorful {
    _colofulIng = NO;
}

@end

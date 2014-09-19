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

#import <UIKit/UIKit.h>

@interface DDProgressView : UIView

/* 0.0 .. 1.0, default is 0.0. values outside are pinned. */
@property (nonatomic) float progress;

/*
 * @param:color --> mask layer color
 */
- (id)initWithFrame:(CGRect)frame backGroundColor:(UIColor *)color;

/* set progress with a animation (not immediately) */
- (void)setProgress:(float)progress duation:(float)seconds animated:(BOOL)animated ;

/* continue colorful */
- (void) startColorful;

/* stop colorful */
- (void) stopColorful;
@end

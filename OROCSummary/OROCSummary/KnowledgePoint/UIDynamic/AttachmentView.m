//
//  AttachmentView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "AttachmentView.h"

@interface AttachmentView()
{
    
    UIImageView             *_anchorImage;
    UIImageView             *_offsetImage;
}

@end

@implementation AttachmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 下方块下移
        self.box.center = CGPointMake(self.center.x, 200);
        
        // 手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        
        [self addGestureRecognizer:pan];
        
        // 附加行为
        CGPoint anchor = CGPointMake(self.box.center.x, self.box.center.y - 100);
        
        UIOffset offset = UIOffsetMake(0, 0);
        
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.box offsetFromCenter:offset attachedToAnchor:anchor];
        
        [self.animator addBehavior:attachment];
        
        _attachment = attachment;
        
        // 定位点，使用一个图像视图
        UIImage *image = [UIImage imageNamed:@"AttachmentPoint_Mask"];
        
        UIImageView *anchorImage = [[UIImageView alloc] initWithImage:image];
        anchorImage.center = anchor;
        
        [self addSubview:anchorImage];
        
        _anchorImage = anchorImage;
        
        // 偏移点，轴，也是用一个图像视图
        UIImageView *offsetImage = [[UIImageView alloc] initWithImage:image];
        
        CGFloat x = self.box.bounds.size.width / 2 + offset.horizontal;
        CGFloat y = self.box.bounds.size.height / 2 + offset.vertical;
        
        offsetImage.center = CGPointMake(x, y);
        
        [self.box addSubview:offsetImage];
        
        _offsetImage = offsetImage;
        
        // 在两点之间画一条实线
    }
    
    return self;
}

#pragma mark - 拖动手势
- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    if (UIGestureRecognizerStateChanged == recognizer.state) {
        CGPoint location = [recognizer locationInView:self];
        
        _attachment.anchorPoint = location;
        _anchorImage.center = location;
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // moveto
    CGContextMoveToPoint(context, _anchorImage.center.x, _anchorImage.center.y);
    
    // addline
    // 去偏移点相对于父视图的坐标
    CGPoint p = [self convertPoint:_offsetImage.center fromView:self.box];
    CGContextAddLineToPoint(context, p.x, p.y);
    
    CGFloat lengths[] = {10.0f, 8.0f};
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    CGContextSetLineWidth(context, 5.0f);
    
    CGContextDrawPath(context, kCGPathStroke);
}


@end

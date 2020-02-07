//
//  LYDrawView.m
//  LYDrawTest
//
//  Created by 李玉臣 on 2020/2/7.
//  Copyright © 2020 LYfinacial.com. All rights reserved.
//

#import "LYDrawView.h"
#import "LYDrawLayer.h"

@implementation LYDrawView

+(Class)layerClass {

    return [LYDrawLayer class];
}

-(void)drawRect:(CGRect)rect {

}

- (void)setNeedsDisplay {
    [self.layer setNeedsDisplay];
}

-(void)displayLayer:(LYDrawLayer *)layer {
    if (!layer) {
        return;
    }
    [self _displayLayer:layer rect:self.bounds];

}

- (BOOL)drawInRect:(CGRect)rect withContext:(CGContextRef)context asynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo {

    // backgroundColor
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, rect);

    // borderWidth
    CGContextAddPath(context, [UIBezierPath bezierPathWithRect:rect].CGPath);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextDrawPath(context, kCGPathFillStroke);

    UIGraphicsPushContext(context);
    UIImage *image = [UIImage imageNamed:@"a5a61ab8c196836fe1efbcd9d33edc44"];
    [image drawInRect:CGRectInset(rect, 8, 8)];
    UIGraphicsPopContext();

    return YES;
}

- (void) _displayLayer:(LYDrawLayer *)layer rect:(CGRect) rectToDraw {
    BOOL drawInBackground = layer.isAsyncDrawsCurrentContent ;

    // 绘制Block
    void(^drawBlock)(void) = ^{
        CGSize contextSize = layer.bounds.size;
        BOOL contextSizeValid = contextSize.width >= 1 && contextSize.height >= 1;
        CGContextRef context = NULL;
        BOOL drawingFinished = YES;

        if (contextSizeValid) {
            
            UIGraphicsBeginImageContextWithOptions(contextSize, layer.isOpaque, layer.contentsScale);

            context = UIGraphicsGetCurrentContext();

            CGContextSaveGState(context);

            if (rectToDraw.origin.x || rectToDraw.origin.y) {
                CGContextTranslateCTM(context, rectToDraw.origin.x, -rectToDraw.origin.y);
            }

            drawingFinished = [self drawInRect:rectToDraw withContext:context asynchronously:drawInBackground userInfo:@{}];

            CGContextRestoreGState(context);
        }

        if (drawingFinished) {
            CGImageRef CGImage = context ? CGBitmapContextCreateImage(context) : NULL;
            {
                UIImage *image = CGImage ? [UIImage imageWithCGImage:CGImage] : nil;

                void (^finishBlock)(void) = ^{
                    layer.contents = (id)image.CGImage;
                };

                if (drawInBackground) {
                    dispatch_async(dispatch_get_main_queue(), finishBlock);
                }else {
                    finishBlock();
                }
            }
            if (CGImage) {
                CGImageRelease(CGImage);
            }
        }
        UIGraphicsEndImageContext();
    };


    if (drawInBackground) {

        layer.contents = nil;

        dispatch_async(dispatch_get_global_queue(0, 0),drawBlock);
    }
}
@end

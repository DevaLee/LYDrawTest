//
//  LYDrawTextView.m
//  LYDrawTest
//
//  Created by 李玉臣 on 2020/2/7.
//  Copyright © 2020 LYfinacial.com. All rights reserved.
//

#import "LYDrawTextView.h"
#import <CoreText/CoreText.h>

@implementation LYDrawTextView


-(BOOL)drawInRect:(CGRect)rect withContext:(CGContextRef)context asynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo {
    [super drawInRect:rect withContext:context asynchronously:asynchronously userInfo:userInfo];


    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);

    // 创建 绘制的区域
    CGMutablePathRef path = CGPathCreateMutable();
       CGRect bounds = CGRectInset(rect, 8, 8);
       CGPathAddRect(path, NULL, bounds);

    // 创建NSMutableString
       CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");

       CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
       // 将 textString 复制到 attrString中
       CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString);

       // 创建Color
       CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
       CGFloat components[] = {1.0,0.0,0.0,0.8};
       CGColorRef red = CGColorCreate(rgbColorSpace, components);
       CGColorSpaceRelease(rgbColorSpace);

       // 设置前12位的颜色
       CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red);

       // 使用attrString 创建 framesetter
       CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
       CFRelease(attrString);

       // 创建ctframe
       CTFrameRef ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
       // 在当前context 绘制ctframe
       CTFrameDraw(ctframe, context);


       CFRelease(ctframe);
       CFRelease(path);
       CFRelease(framesetter);


    return YES;
}

@end

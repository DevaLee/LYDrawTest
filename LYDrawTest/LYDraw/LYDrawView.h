//
//  LYDrawView.h
//  LYDrawTest
//
//  Created by 李玉臣 on 2020/2/7.
//  Copyright © 2020 LYfinacial.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDrawView : UIView


// 子类重写
- (BOOL)drawInRect:(CGRect)rect withContext:(CGContextRef)context asynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END

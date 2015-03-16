//
//  UIView+CircularProfileImage.m
//  KeepTest
//
//  Created by ilteris on 3/15/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

#import "UIView+CircularProfileImage.h"
//simple category for making any UIView circular adding border width = 3 with white color.
@implementation UIView (CircularProfileImage)

+(UIView*)createAndReturnCircularProfileImage:(UIView*)imageView
{
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.clipsToBounds = YES;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    return imageView;
}

@end

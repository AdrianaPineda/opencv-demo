//
//  OpenCVWrapper.m
//  OpenCVDemo
//
//  Created by Adriana Pineda on 03/10/2020.
//  Copyright © 2020 Adriana Pineda. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

@end

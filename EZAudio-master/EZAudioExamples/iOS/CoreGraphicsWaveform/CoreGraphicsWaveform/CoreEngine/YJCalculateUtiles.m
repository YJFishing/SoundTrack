//
//  YJCalculateUtiles.m
//  EZAudio
//
//  Created by 包宇津 on 2017/8/27.
//  Copyright © 2017年 Andrew Breckenridge. All rights reserved.
//

#import "YJCalculateUtiles.h"

@implementation YJCalculateUtiles


+ (float)timesOfBreathInArray:(NSMutableArray *)array {
    float minSpace = MAXFLOAT;
    float sum = 0.f;
    float lengthSample = 0.f;
    NSInteger target = 0;
    float result = 0.f;
    for (int j = 16000; j<= 32000; j++) {
        for (int k = 0 ; k < (array.count - 32000 -1); k = k + 80) {
            float a = [array[k] floatValue];
            float b = [array[k + j] floatValue];
            float c = pow((a-b),2);
            sum += c;
        }
        if (minSpace > (sqrt(sum) / (array.count - 32000 -1))) {
            minSpace = (sqrt(sum) / (array.count - 32000 -1));
            target = j;
        }
    }
    result = (float)(target / 8000);
    return result;
}
@end

//
//  sleepDataHolder.m
//  EZAudio
//
//  Created by 包宇津 on 2017/6/1.
//  Copyright © 2017年 Andrew Breckenridge. All rights reserved.
//

#import "sleepDataHolder.h"

@implementation sleepDataHolder
-(NSMutableArray *)bufferArray {
    if (_bufferArray == nil) {
        _bufferArray = [NSMutableArray new];
    }
    return _bufferArray;
}

-(NSMutableArray *)addDataFromBuffer:(float *)buffer withBufferSize:(NSInteger)bufferSize {
    if (self.bufferArray.count < 512 * 78) {
        for (int i = 0; i < bufferSize; i++) {
        [self.bufferArray addObject:@(buffer[i])];
        }
        return _bufferArray;
    } else if (self.bufferArray.count>= 512 * 78) {
        NSLog(@"count == %lu   bufferArray = %@",(unsigned long)self.bufferArray.count,self.bufferArray);
        return self.bufferArray;
    }else {
        return nil;
    }
}

-(NSMutableArray *)newAddDataFromBuffer:(float **)buffer withBufferSize:(NSInteger)bufferSize {
    if (self.bufferArray.count < 512 * 78) {
        NSMutableArray *arrayTemp = [NSMutableArray new];
        for (int i = 0;i < bufferSize; i++) {
            [arrayTemp addObject:@(buffer[0][i])];
        }
        [self.bufferArray addObjectsFromArray:arrayTemp];
        [arrayTemp removeAllObjects];
    } else {
//        NSLog(@"count = %lu    bufferArray = %@",(unsigned long)self.bufferArray.count,self.bufferArray);
        return _bufferArray;
    }
    return nil;
}
//- (void)setSampleData:(float *)data length:(int)length
//{
//    CGPoint *points = self.points;
//    for (int i = 0; i < length; i++)
//    {
//        points[i].x = i;
//        points[i].y = data[i] * self.gain;
//    }
//    points[0].y = points[length - 1].y = 0.0f;
//    self.pointCount = length;
//}

//清除掉数据当中的错误数据
-(NSMutableArray *)getRawDataFromArray:(NSMutableArray *)array {
    for (int i =0 ;i< array.count; i++) {
//        if ((NSInteger)array[i] < -0.00001 || (NSInteger)array[i] >100000 ) {
//            [array removeObjectAtIndex:i];
//        }
        if (fabsf([array[i] floatValue]) > 5 || fabsf([array[i] floatValue]) < 0.000001) {
            [array removeObjectAtIndex:i];
        }
    }
    return array;
}
@end

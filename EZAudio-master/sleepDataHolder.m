//
//  sleepDataHolder.m
//  EZAudio
//
//  Created by 包宇津 on 2017/6/1.
//  Copyright © 2017年 Andrew Breckenridge. All rights reserved.
//

#import "sleepDataHolder.h"
@interface sleepDataHolder()
@property (nonatomic, strong) NSMutableArray *tempArray;
@end
@implementation sleepDataHolder
-(NSMutableArray *)tempArray {
    if (_tempArray) {
        return _tempArray;
    }
    _tempArray = [NSMutableArray new];
    return  _tempArray;
}
-(NSMutableArray *)bufferArray {
    if (_bufferArray == nil) {
        _bufferArray = [[NSMutableArray alloc] init];
    }
    return _bufferArray;
}

-(NSMutableArray *)addDataFromBuffer:(float *)buffer withBufferSize:(NSInteger)bufferSize {
    if (self.bufferArray.count < 512 * 78) {
        for (int i = 0;i < bufferSize; i++) {
            [self.tempArray addObject:@(buffer[i])];
        }
        [self.bufferArray addObjectsFromArray:_tempArray];
        [_tempArray removeAllObjects];
    } else {
        //        NSLog(@"count = %lu    bufferArray = %@",(unsigned long)self.bufferArray.count,self.bufferArray);
        return self.bufferArray;
    }
    return nil;
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
//    for (int i = 0; i < length; i++)®
//    {
//        points[i].x = i;®
//        points[i].y = data[i] * self.gain;
//    }
//    points[0].y = points[length - 1].y = 0.0f;
//    self.pointCount = length;
//}

//清除掉数据当中的错误数据
-(NSMutableArray *)getRawDataFromArray:(NSMutableArray *)array {
    for (int i =0 ;i< array.count; i++) {
        if (fabsf([array[i] floatValue]) > 5 || fabsf([array[i] floatValue]) < 0.0001) {
            [array removeObjectAtIndex:i];
        }
    }
    return array;
}

- (NSMutableArray *)historyBufferWithBuffer:(float *)buffer bufferSize:(NSInteger)bufferSize {
    if (self.bufferArray.count < 8000 * 5) {
        for (int i = 0;i < bufferSize; i++) {
            [self.tempArray addObject:@(buffer[i])];
        }
        [self.bufferArray addObjectsFromArray:[self createCalculateArrayWithBufferArray:self.tempArray]];
        [_tempArray removeAllObjects];
    }else {
        NSLog(@"count = %lu   trueArray = %@",(unsigned long)self.bufferArray.count,self.bufferArray);
        return _bufferArray;
    }
    return _bufferArray;
}




#pragma mark --计算逻辑
//每800个点求一个平均值
- (NSMutableArray *)createCalculateArrayWithBufferArray:(NSMutableArray *)bufferArray{
    float sum = 0.0;
    float avarValue = 0.0;
    NSMutableArray *calculateArray = [NSMutableArray new];
    for (int i = 0;i< bufferArray.count;i++) {
        sum += ([bufferArray[i]  floatValue] * 1000);
    }
    avarValue = sum / bufferArray.count;
    for (int i = 0;i < bufferArray.count; i++) {
        calculateArray[i] = @(avarValue);
    }
    return calculateArray;
}
@end

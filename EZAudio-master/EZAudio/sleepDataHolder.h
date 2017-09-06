//
//  sleepDataHolder.h
//  EZAudio
//
//  Created by 包宇津 on 2017/6/1.
//  Copyright © 2017年 Andrew Breckenridge. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface sleepDataHolder : NSObject
@property (nonatomic, copy) NSMutableArray *bufferArray;
@property (nonatomic, assign) float **buffer;

-(NSMutableArray *)addDataFromBuffer:(float *)buffer withBufferSize:(NSInteger)bufferSize;
-(NSMutableArray *)newAddDataFromBuffer:(float **)buffer withBufferSize:(NSInteger)bufferSize;
-(NSMutableArray *)getRawDataFromArray:(NSMutableArray *)array;

//存放history Info
- (NSMutableArray *)historyBufferWithBuffer:(float *)buffer bufferSize:(NSInteger)bufferSize;
@end

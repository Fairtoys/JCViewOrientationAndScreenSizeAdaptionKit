//
//  JCStateStorage.h
//  JCViewOrientationAndScreenSizeAdaptionKit
//
//  Created by huajiao on 2018/5/15.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCStateStorage : NSObject

- (void)setValue:(id)value forState:(id <NSCopying>)state;
- (void)setValue:(id)value forStateInt:(NSInteger)state;

- (nullable id)valueForState:(id <NSCopying>)state;
- (nullable id)valueForStateInt:(NSInteger)state;

@property (nonatomic, copy, nullable) id valueForDefault;//默认值，如果该状态下没有对应的值，则会返回此对象

@property (nonatomic, strong, nullable) id <NSCopying> state;
@property (nonatomic, readonly) id value;//当前状态对应的值

@end

NS_ASSUME_NONNULL_END

//
//  JCStateStorage.h
//  JCViewOrientationAndScreenSizeAdaptionKit
//
//  Created by huajiao on 2018/5/15.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class JCStateStorage;

typedef void(^JCStateStorageBlock)(JCStateStorage *theStateStorage);

@interface JCStateStorage <KeyType, ObjectType> : NSObject

- (void)setValue:(nullable ObjectType)value forState:(KeyType <NSCopying>)state;
- (void)setValue:(nullable ObjectType)value forStateInt:(NSInteger)state;

- (nullable ObjectType)valueForState:(KeyType <NSCopying>)state;
- (nullable ObjectType)valueForStateInt:(NSInteger)state;

@property (nonatomic, copy, nullable) ObjectType valueForDefault;//默认值，如果该状态下没有对应的值，则会返回此对象

@property (nonatomic, strong, nullable) KeyType <NSCopying> state;
@property (nonatomic, readonly, nullable) ObjectType value;//当前状态对应的值

@property (nonatomic, copy, nullable) JCStateStorageBlock onValueDidSetBlock;//当value设置的回调

@end

NS_ASSUME_NONNULL_END

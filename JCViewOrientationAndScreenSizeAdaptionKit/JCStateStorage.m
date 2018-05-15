//
//  JCStateStorage.m
//  JCViewOrientationAndScreenSizeAdaptionKit
//
//  Created by huajiao on 2018/5/15.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import "JCStateStorage.h"

@interface JCStateStorage ()
@property (nonatomic, strong) NSMutableDictionary <id <NSCopying>, id> *valuesForState;
@property (nonatomic, strong) id value;
@end


@implementation JCStateStorage

- (NSMutableDictionary<id<NSCopying>,id> *)valuesForState{
    if (!_valuesForState) {
        _valuesForState = [NSMutableDictionary dictionary];
    }
    return _valuesForState;
}

- (void)setValue:(id)value forState:(id<NSCopying>)state{
    self.valuesForState[state] = value;
    [self _setValueForState:self.state];
}

- (void)setValue:(id)value forStateInt:(NSInteger)state{
    [self setValue:value forState:@(state)];
}
- (id)valueForState:(id<NSCopying>)state{
    return self.valuesForState[state];
}

- (id)valueForStateInt:(NSInteger)state{
    return [self valueForState:@(state)];
}

- (void)setValueForDefault:(id)valueForDefault{
    NSString *keyForDefault = NSStringFromSelector(@selector(valueForDefault));
    if (!_state) {
        _state = keyForDefault;
    }
    [self setValue:valueForDefault forState:keyForDefault];
}

- (void)_setValueForState:(id <NSCopying>)state{
    id value = [self valueForState:state] ?: self.valueForDefault;
    if (!value) {
        return ;
    }
    self.value = value;
}

- (void)setState:(id<NSCopying>)state{
    if (_state == state) {
        return ;
    }
    
    _state = state;
    
    [self _setValueForState:state];
}

@end

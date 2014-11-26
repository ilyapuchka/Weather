//
//  COOLSwitchComposition.m
//  CoolEvents
//
//  Created by Ilya Puchka on 08.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLSwitchComposition.h"
#import "NSArray+Extensions.h"

@interface COOLSwitchComposition()

@property (nonatomic, strong) NSObject *currentObject;
@property (nonatomic, assign) NSUInteger currentObjectIndex;

@end

@implementation COOLSwitchComposition

- (instancetype)init
{
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(NSArray *)objects
{
    self = [super initWithArray:objects];
    if (self) {
        [self switchToObjectAtIndex:0];
    }
    return self;
}

- (BOOL)switchToObject:(id)object
{
    if ([self.objects containsObject:object]) {
        self.currentObject = object;
        self.currentObjectIndex = [self.objects indexOfObject:object];
        return YES;
    }
    return NO;
}

- (BOOL)switchToObjectAtIndex:(NSUInteger)index
{
    if (index < self.objects.count) {
        self.currentObjectIndex = index;
        self.currentObject = self.objects[index];
        return YES;
    }
    return NO;
}

- (void)removeObject:(id)object
{
    if (object == self.currentObject) {
        [NSException raise:@"Invalid object" format:@"Can not remove currently active object"];
    }
    self.objects = [self.objects cool_removeObject:object];
}

- (void)removeObjectAtIndex:(NSUInteger)idx
{
    if (idx == self.currentObjectIndex) {
        [NSException raise:@"Invalid object" format:@"Can not remove currently active object"];
    }
    self.objects = [self.objects cool_removeObject:self.objects[idx]];
}

#pragma mark - Invocations forwarding

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    if ([self.currentObject respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:self.currentObject];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

@end

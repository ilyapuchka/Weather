//
//  COOLComposition.h
//  CoolEvents
//
//  Created by Ilya Puchka on 08.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COOLComposition <NSObject, NSFastEnumeration>

- (instancetype)initWithArray:(NSArray *)objects;

- (void)addObject:(id)object;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)idx;

- (NSUInteger)indexOfObject:(id)object;

- (NSUInteger)count;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@end

//Methods that are not implemented in composition are passed to objects.
@interface COOLComposition : NSObject <COOLComposition> {
    NSArray *_objects;
}

@property (nonatomic, copy) NSArray *objects;

//after calling this method messages will be forwarded to each object one after another.
- (instancetype)makeAll;

//after calling this method messages will be forwarded only to first responder from objects. This is default behaviour.
- (instancetype)makeFirst;

//after calling this method messages will be forwarded only to object at passed index.
//- (instancetype)makeAtIndex:(NSUInteger)index;

@end

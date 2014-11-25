//
//  COOLAPIResponseBuilder.m
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 06.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIResponseBuilder.h"
#import "COOLAPIResponse+Package.h"

@interface COOLAPIResponseBuilder()

@property (nonatomic, strong, readwrite) id mappedResponseObject;

@end

@implementation COOLAPIResponseBuilder

- (COOLAPIResponse *)build:(Class)classToBuild
{
    self.mappedResponseObject = [[self.responseMapper class]
                                 objectFromExternalRepresentation:self.responseObject
                                 withMapping:self.responseMapping];
    
    return [[classToBuild alloc] initWithBuilder:self];
}

@end


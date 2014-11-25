//
//  COOLMapper.h
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 04.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COOLMapper <NSObject>

+ (id)objectFromExternalRepresentation:(id)externalRepresentation withMapping:(id)mapping;
+ (NSArray *)arrayOfObjectsFromExternalRepresentation:(NSArray *)externalRepresentation withMapping:(id)mapping;

@end

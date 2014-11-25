//
//  COOLWeatherAPI.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COOLWeatherAPI <NSObject>

- (void)searchCitiesWithQuery:(NSString *)query success:(id)succes failure:(id)faulure;
- (void)weatherWithQuery:(NSString *)query success:(id)success failure:(id)failure;
- (void)weatherWithBatchQuery:(NSArray *)queries success:(id)success failure:(id)failure;

@end

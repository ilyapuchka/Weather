//
//  Hourly.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Hourly : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *winddir16Point;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *tempF;
@property (nonatomic, strong) NSString *chanceofthunder;
@property (nonatomic, strong) NSString *chanceofsnow;
@property (nonatomic, strong) NSString *chanceofrain;
@property (nonatomic, strong) NSString *chanceofsunshine;
@property (nonatomic, strong) NSString *windspeedKmph;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *windspeedMiles;
@property (nonatomic, strong) NSArray *weatherDesc;
@property (nonatomic, strong) NSArray *localizedWeatherDesc;
@property (nonatomic, strong) NSString *tempC;
@property (nonatomic, strong) NSString *precipMM;
@property (nonatomic, strong) NSString *time;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

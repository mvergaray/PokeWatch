//
//  DataBase.h
//  iphone4peru.com
//
//  Created by Christian Quicano on 4/18/14.
//  Copyright (c) 2014 Electronic Core Networks S.A.C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBase : NSObject
+(NSString *)getDataBasePath;
+(void) checkAndCreateDatabase;
- (NSArray *)ejecutarSelect:(NSString *)select;
- (void)ejecutarInsert:(NSString *)insert;
- (void)ejecutarDelete:(NSString *)deleteString;
- (void)ejecutarUpdate:(NSString *)update;
@end

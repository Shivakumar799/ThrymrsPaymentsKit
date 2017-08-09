//
//  SharedData.h
//  CCGateway
//
//  Created by Thrymr on 07/08/17.
//  Copyright © 2017 Thrymr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject


+(SharedData *)sharedInstance;

#pragma  mark ParseData
+(NSMutableDictionary*)parseCCAvenueResponse:(NSString *)html;

@end

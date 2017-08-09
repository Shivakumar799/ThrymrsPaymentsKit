//
//  CCTool.h
//  CCIntegrationKit
//
//  Created by test on 5/14/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ComplitionHandlerCCTool)(id response, NSError *error);

@interface CCTool : NSObject
- (void)encryptRSA:(NSString *)raw key:(NSString *)pubKey withCompileHandler:(ComplitionHandlerCCTool)compileHandler;
@end

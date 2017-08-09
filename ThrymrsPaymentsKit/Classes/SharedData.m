//
//  SharedData.m
//  CCGateway
//
//  Created by Thrymr on 07/08/17.
//  Copyright © 2017 Thrymr. All rights reserved.
//

#import "SharedData.h"
#import "TFHpple.h"

static SharedData *singletonInstance = nil;


@implementation SharedData
+(SharedData *)sharedInstance
{
    if (nil != singletonInstance)
        return singletonInstance;
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        
        singletonInstance = [[SharedData alloc] init];
        
    });
    
    return singletonInstance;
}


#pragma  mark Parse Data
+(NSMutableDictionary*)parseCCAvenueResponse:(NSString *)html
{
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding] ;
    
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:data];
    
    NSString *tutorialsXpathQueryString = @"//tr/td";
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    
    
    NSMutableArray *newTutorials = [[NSMutableArray alloc] init];
    NSMutableDictionary  *dict = [NSMutableDictionary new];
    
    int i=0;
    if (tutorialsNodes.count>0) {
        for (TFHppleElement *element in tutorialsNodes) {
            
            
            TFHppleElement *subelement = [element firstChild];
            //  if ([[subelement tagName] isEqualToString:@"font"])
            // subelement = [subelement firstChild];
            // NSLog(@"%@", subelement.content);
            NSString *str;
            if(![subelement.content isKindOfClass:[NSNull class]]){
                str=(subelement.content.length>0)?subelement.content:@"";
            }else{
                str=@"";
            }
            
            [newTutorials addObject:str];
            
            if (i%2!=0) {
                [dict setObject:newTutorials[i] forKey:newTutorials[i-1]];
            }
            i+=1;
            
            //  tutorial.title = [subelement content];
            
            // NSLog(@"title is: %@", [element description]);
        }
        
    }
    
    return dict;
    
}



@end

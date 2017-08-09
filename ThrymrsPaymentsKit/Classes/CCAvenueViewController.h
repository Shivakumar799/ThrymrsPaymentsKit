//
//  CCAvenuePaymentViewController.h
//  CCGateway
//
//  Created by Thrymr on 07/08/17.
//  Copyright © 2017 Thrymr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ComplitionHandler)(id response, NSError *error);

@protocol PaymentDelegate <NSObject>

-(void)paymentStatusDelegate:(NSString *)statusMessage withDict:(NSMutableDictionary *)responseDict;

@end




@interface CCAvenueViewController : NSObject
//@property (strong, nonatomic) UIWebView *ccAvenueWebView;

+(CCAvenueViewController *)sharedInstance;

#pragma  mark ParseData
+(void)passParametersForCCAvenue:(NSString *)CCAvenueRSAURL accessCode:(NSString *)CCAVENUE_ACCESSCODE  transitionURL:(NSString *)CCAVENUE_TRANSITIONURL redirectURL:(NSString *)REDIRECT_URL merchantID:(NSString *)CCAVENUE_MERCHANTID orderId:(NSString *)OrderID currencyType:(NSString *)CURRENCY_TYPE amount:(NSString *)AMOUNT name:(NSString *)customer_name email:(NSString *)customer_email state:(NSString *)customer_state zipcode:(NSString *)customer_zipcode city:(NSString *)customer_city country:(NSString *)customer_country mobileNo:(NSString *)customer_MobileNum cancelURL:(NSString *)CANCEL_URL complitionHandler:(ComplitionHandler)complitionHandler;

@property(nonatomic,strong) NSString *CCAvenueRSAURL;

@property(nonatomic,strong) NSString *CCAVENUE_ACCESSCODE;

@property(nonatomic,strong) NSString *CCAVENUE_TRANSITIONURL;

@property(nonatomic,strong)NSString *redirectURL;

@property(nonatomic,strong)NSString *REDIRECT_URL;

@property(nonatomic,strong)NSString *CCAVENUE_MERCHANTID;

@property(nonatomic,strong)NSString *RSAKEYURL;

@property(nonatomic,strong) NSString *orderId;

@property(nonatomic,strong)NSString *currencyType;
@property(nonatomic,strong)NSString *amount;

@property(nonatomic,strong)NSString *encValue;


@property(nonatomic,strong)NSString *CANCEL_URL;

@property(nonatomic,weak) id<PaymentDelegate> delegate;

@end

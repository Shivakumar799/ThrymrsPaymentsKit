//
//  CCAvenueViewController.m
//  PaymentsKit
//
//  Created by Thrymr on 07/08/17.
//  Copyright © 2017 Thrymr. All rights reserved.
//

#import "CCAvenueViewController.h"

#import "CCTool.h"
#import "SharedData.h"

@interface CCAvenueViewController ()<UIWebViewDelegate>

@end


static CCAvenueViewController *singletonInstance = nil;



@implementation CCAvenueViewController


+(CCAvenueViewController *)sharedInstance
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        singletonInstance = [[CCAvenueViewController alloc] init];
    });
    
    return singletonInstance;
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    _ccAvenueWebView = [[UIWebView alloc] init];
//    
//    _ccAvenueWebView.delegate = self;
//    
//    
//    /*
//     
//     
//     
//     NSString *myRequestString = [NSString stringWithFormat:@"amount=%@&currency=%@",_amount,_currencyType];
//     CCTool *ccTool = [[CCTool alloc] init];
//     NSString *encVal= [ccTool encryptRSA:myRequestString key:_encValue];
//     encVal = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
//     (CFStringRef)encVal,
//     NULL,
//     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//     kCFStringEncodingUTF8 ));
//     
//     
//     
//     NSString *urlAsString = [NSString stringWithFormat:@"https://secure.ccavenue.com/transaction/initTrans"];
//     NSString *encryptedStr = [NSString stringWithFormat:@"merchant_id=%@&order_id=%@&redirect_url=%@&cancel_url=%@&enc_val=%@&access_code=%@&merchant_param1=%@&merchant_param2=%@&merchant_param3=%@&merchant_param4=%@&merchant_param5=%@",_CCAVENUE_MERCHANTID,_orderId,self.redirectURL,_CANCEL_URL,encVal,_CCAVENUE_ACCESSCODE,@"",@"shiva@gmail.com",@"", _currencyType,_amount];
//     
//     NSData *myRequestData = [NSData dataWithBytes: [encryptedStr UTF8String] length: [encryptedStr length]];
//     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlAsString]];
//     [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
//     [request setValue:urlAsString forHTTPHeaderField:@"Referer"];
//     [request setHTTPMethod: @"POST"];
//     [request setHTTPBody: myRequestData];
//     [_ccAvenueWebView loadRequest:request];
//     */
//    
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    // Google Analytics
//    
//    
//    
//    
//}


+(void)passParametersForCCAvenue:(NSString *)CCAvenueRSAURL accessCode:(NSString *)CCAVENUE_ACCESSCODE transitionURL:(NSString *)CCAVENUE_TRANSITIONURL redirectURL:(NSString *)REDIRECT_URL merchantID:(NSString *)CCAVENUE_MERCHANTID orderId:(NSString *)OrderID currencyType:(NSString *)CURRENCY_TYPE amount:(NSString *)AMOUNT name:(NSString *)customer_name email:(NSString *)customer_email state:(NSString *)customer_state zipcode:(NSString *)customer_zipcode city:(NSString *)customer_city country:(NSString *)customer_country mobileNo:(NSString *)customer_MobileNum cancelURL:(NSString *)CANCEL_URL complitionHandler:(ComplitionHandler)complitionHandler
    {
    
    
    NSString *urlstring =[NSString stringWithFormat:@"%@",CCAvenueRSAURL];
    NSString *rsaKeyDataStr = [NSString stringWithFormat:@"access_code=%@&order_id=%@",CCAVENUE_ACCESSCODE,OrderID];
    NSLog(@"%@",rsaKeyDataStr);
    NSData *requestData = [NSData dataWithBytes: [rsaKeyDataStr UTF8String] length: [rsaKeyDataStr length]];
    
    NSMutableURLRequest *request  = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlstring parameters:rsaKeyDataStr error:nil];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: requestData];
    NSData *rsaKeyData = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil];
    NSString *rsaKey = [[NSString alloc] initWithData:rsaKeyData encoding:NSASCIIStringEncoding];
    NSLog(@"rsaKey:%@",rsaKey);
    
    rsaKey = [rsaKey stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    rsaKey = [NSString stringWithFormat:@"-----BEGIN PUBLIC KEY-----\n%@\n-----END PUBLIC KEY-----\n",rsaKey];
    
    //    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //    NSData *jsonData = [self sendRequestToServer:methodName withObject:rsaKeyDataStr];
    
    NSString *myRequestString = [NSString stringWithFormat:@"amount=%@&currency=%@",AMOUNT,CURRENCY_TYPE];
    CCTool *ccTool = [[CCTool alloc] init];
    [ccTool encryptRSA:myRequestString key:rsaKey withCompileHandler:^(id response, NSError *error) {
        
        NSString *encValue1 = (NSString *)response;
       encValue1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                         (CFStringRef)encValue1,
                                                                                         NULL,
                                                                                         (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                         kCFStringEncodingUTF8 ));
        
        NSString *urlAsString = [NSString stringWithFormat:@"%@", CCAVENUE_TRANSITIONURL];
        NSString *encryptedStr=[NSString stringWithFormat:@"merchant_id=%@&order_id=%@&redirect_url=%@&cancel_url=%@&enc_val=%@&access_code=%@&amount=%@&currency=%@&rsa_key_url=%@&billing_name=%@&billing_address=%@&billing_state=%@&billing_country=%@&billing_city=%@&billing_zip=%@&billing_tel=%@&billing_email=%@", CCAVENUE_MERCHANTID,OrderID,REDIRECT_URL,CANCEL_URL,encValue1,CCAVENUE_ACCESSCODE,AMOUNT,CURRENCY_TYPE,CCAvenueRSAURL,customer_name,customer_city,customer_state, customer_country,customer_city,customer_zipcode,customer_MobileNum, customer_email];
        //NSLog(@"%@",encryptedStr);
        
        NSData *myRequestData = [NSData dataWithBytes: [encryptedStr UTF8String] length: [encryptedStr length]];
        NSMutableURLRequest *requestNew = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlAsString]];
        [requestNew setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [requestNew setValue:urlAsString forHTTPHeaderField:@"Referer"];
        [requestNew setHTTPMethod: @"POST"];
        [requestNew setHTTPBody: myRequestData];
        
        complitionHandler(requestNew, nil);
    }];
    
    
    
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self callPaymentWebviewForCCAvenue:CCAvenueRSAURL accessCode:CCAVENUE_ACCESSCODE transitionURL:CCAVENUE_TRANSITIONURL redirectURL:REDIRECT_URL merchantID:CCAVENUE_MERCHANTID orderId:OrderID currencyType:CURRENCY_TYPE amount:AMOUNT name:customer_name email:customer_email state:customer_state zipcode:customer_zipcode city:customer_city country:customer_country mobileNo:customer_MobileNum cancelURL:CANCEL_URL  encValue:(NSString *)encValue1];
//    }) ;
        

    
    //[self performSelector:@selector(callPaymentWebview) withObject:nil afterDelay:0.2];
    
    
    //    NSString *email = @"shiva@gmail.com";
    //
    //    NSString *state = @"Telangana";//([[self.placemark objectForKey:@"State"] length]>0)?[self.placemark objectForKey:@"State"]:@"";
    //
    //    NSString *zip = @"500032";//([[self.placemark objectForKey:@"ZIP"] length]>0)?[self.placemark objectForKey:@"ZIP"]:@"";
    //
    //    NSString *city = @"Hyderabad";//([[self.placemark objectForKey:@"City"] length]>0)?[self.placemark objectForKey:@"City"]:@"";
    //
    //    NSString *country = @"INDIA";//([[self.placemark objectForKey:@"Country"] length]>0)?[self.placemark objectForKey:@"Country"]:@"";
    
    
    
    
    
    
    
    
}



//- (void)webViewDidFinishLoad:(NSString *)webView{
//    
//    NSString *string = webView.request.URL.absoluteString;
//    NSLog(@"WEBVIEW****** %@", string);
//    
//    
//    if ([string rangeOfString:@"/ccavResponseHandler.php"].location != NSNotFound) {
//        //  NSLog(@"PAYMEN SUCEESS");
//        NSString *string = webView.request.URL.absoluteString;
//        NSLog(@"WEBVIEW****** %@", string);
//        NSString  *html = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
//        
//        NSMutableDictionary *dict = [SharedData parseCCAvenueResponse:html];
//        NSLog(@"SUDHEER****** %@", html);
//        NSString *status ;
//        if ([html rangeOfString:@"Failure"].location != NSNotFound) {
//            status = @"Transaction Declined!";
//        }
//        else if ([html rangeOfString:@"Success"].location != NSNotFound) {
//            status = @"Transaction Successful!";
//        }
//        else if ([html rangeOfString:@"Aborted"].location != NSNotFound) {
//            status = @"Transaction Cancelled!";
//        }else{
//            status = @"Status Not Known!";
//        }
//        //[AppHelper saveToUserDefaults:html withKey:@"PAYMENTRESPONSE"];
////        [self dismissViewControllerAnimated:YES completion:nil];
////        [self.delegate paymentStatusDelegate:status withDict:dict];
////        _ccAvenueWebView.hidden = YES;
//        
//    }
//    
//    
//}

@end

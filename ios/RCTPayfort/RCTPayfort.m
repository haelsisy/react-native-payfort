//
//  RCTPayfort.m
//  RCTPayfort
//
//  Created by Hazem El-Sisy on 1/21/18.
//  Copyright © 2018 Hazem El-Sisy. All rights reserved.
//

#import "RCTPayfort.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import <PayFortSDK/PayFortSDK.h>
#import <React/RCTBridge.h>
#include <CommonCrypto/CommonDigest.h>

@implementation RCTPayfort
@synthesize bridge = _bridge;

NSString *sdk_token;
NSMutableData *webDataglobal;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(initPayfort:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self initializePayfort:input callback:callback];
}

- (void)initializePayfort:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSNumber *isLive = [input objectForKey:@"isLive"];
    NSString *access_code = [input objectForKey:@"access_code"];
    NSString *merchant_identifier = [input objectForKey:@"merchant_identifier"];
    NSString *language = [input objectForKey:@"language"];

    PayFortController *PayFort = [[PayFortController alloc]initWithEnviroment:KPayFortEnviromentSandBox];
    NSMutableString *post = [NSMutableString string];
    [post appendFormat:@"TESTSHAINaccess_code=%@", access_code];
    [post appendFormat:@"device_id=%@",  [PayFort getUDID ]];
    [post appendFormat:@"language=%@", language];
    [post appendFormat:@"merchant_identifier=%@", merchant_identifier];
    [post appendFormat:@"service_command=%@", @"SDK_TOKENTESTSHAIN"];

    NSDictionary* tmp = @{ @"service_command": @"SDK_TOKEN",
                           @"merchant_identifier": merchant_identifier,
                           @"access_code": access_code,
                           @"signature": [self sha1Encode:post],
                           @"language": language,
                           @"device_id": [PayFort getUDID ] };
    NSError *error;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];

    NSString *BaseDomain = [isLive  isEqual: @1]? @"https://paymentservices.payfort.com/FortAPI/paymentApi" : @"https://sbpaymentservices.payfort.com/FortAPI/paymentApi";
    NSString *urlString = [NSString stringWithFormat:@"%@",BaseDomain];
    NSString *postLength = [NSString stringWithFormat:@"%ld",[postdata length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postdata];
    
    NSLog(@"url string %@",urlString);
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error)
                                  {
                                      if (!error)
                                      {
                                          NSError *error = nil;
                                          id object = [NSJSONSerialization
                                                       JSONObjectWithData:data
                                                       options:0
                                                       error:&error];
                                          //webDataglobal = [NSMutableData data];
                                          NSLog(@"object %@",object);

                                          if(error) {
                                              NSLog(@"Error %@",error);
                                              return;
                                          }
                                          sdk_token = object[@"sdk_token"];
                                          [self startTheAction:input callback:callback];

                                      }
                                      else
                                      {
                                          NSLog(@"Error: %@", error.localizedDescription);
                                      }
                                  }];
    [task resume];
}

- (NSString*)sha1Encode:(NSString*)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

-(void) startTheAction:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSString *command = [input objectForKey:@"command"];
    NSString *merchant_reference = [input objectForKey:@"merchant_reference"];
    NSString *merchant_extra = [input objectForKey:@"merchant_extra"];
    NSString *merchant_extra1 = [input objectForKey:@"merchant_extra1"];
    NSString *merchant_extra2 = [input objectForKey:@"merchant_extra2"];
    NSString *merchant_extra3 = [input objectForKey:@"merchant_extra3"];
    NSString *merchant_extra4 = [input objectForKey:@"merchant_extra4"];
    NSString *customer_name = [input objectForKey:@"customer_name"];
    NSString *customer_email = [input objectForKey:@"customer_email"];
    NSString *phone_number = [input objectForKey:@"phone_number"];
    NSString *payment_option = [input objectForKey:@"payment_option"];
    NSString *language = [input objectForKey:@"language"];
    NSString *currency = [input objectForKey:@"currency"];
    NSString *amount = [input objectForKey:@"amount"];
    NSString *eci = [input objectForKey:@"eci"];
    NSString *order_description = [input objectForKey:@"order_description"];

    PayFortController *PayFort = [[PayFortController alloc]initWithEnviroment:KPayFortEnviromentSandBox];
    UIViewController *nav =  (UIViewController*)[UIApplication sharedApplication].delegate.window.rootViewController;
    //PayFort.delegate = self;
    
    NSMutableDictionary *request = [[NSMutableDictionary alloc]init];
    [request setValue:command forKey:@"command"];
    [request setValue:sdk_token forKey:@"sdk_token"];
    //[request setValue:@"wOUEfsZm" forKey:@"token_name"];
    [request setValue:merchant_reference forKey:@"merchant_reference"];
    [request setValue:merchant_extra forKey:@"merchant_extra"];
    [request setValue:merchant_extra1 forKey:@"merchant_extra1"];
    [request setValue:merchant_extra2 forKey:@"merchant_extra2"];
    [request setValue:merchant_extra3 forKey:@"merchant_extra3"];
    [request setValue:merchant_extra4 forKey:@"merchant_extra4"];
    [request setValue:customer_name forKey:@"customer_name"];
    [request setValue:customer_email forKey:@"customer_email"];
    [request setValue:phone_number forKey:@"phone_number"];
    [request setValue:payment_option forKey:@"payment_option"];
    [request setValue:language forKey:@"language"];
    [request setValue:currency forKey:@"currency"];
    [request setValue:amount forKey:@"amount"];
    [request setValue:eci forKey:@"eci"];
    [request setValue:order_description forKey:@"order_description"];
    
    //[PayFort setPayFortCustomViewNib:@"PayFortView2"];
    PayFort.IsShowResponsePage = YES;
    [PayFort callPayFortWithRequest:request currentViewController:nav
                                 Success:^(NSDictionary *requestDic, NSDictionary *responeDic) {
                                     NSLog(@"Success");
                                     NSLog(@"responeDic=%@",responeDic);
                                     callback(@[@"",responeDic, @true]);
                                 }
                                Canceled:^(NSDictionary *requestDic, NSDictionary *responeDic) {
                                    NSLog(@"Canceled");
                                    NSLog(@"responeDic=%@",responeDic);
                                    callback(@[RCTMakeError(@"Canceled", nil, nil)]);
                                }
                               Faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
                                   NSLog(@"Faild");
                                   NSLog(@"responeDic=%@",responeDic);
                                   callback(@[RCTMakeError(@"Faild", nil, nil)]);
                               }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    __block UIBackgroundTaskIdentifier backgroundTask;
    backgroundTask =
    [application beginBackgroundTaskWithExpirationHandler: ^ {
        [application endBackgroundTask:backgroundTask];
        backgroundTask = UIBackgroundTaskInvalid; }];
}

- (void)getModuleInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDictionary *info = @{
                           @"name" : @"react-native-payfort",
                           @"description" : @"A React Native bridge module for interacting with Payfort SDK",
                           @"className" : @"RCTPayfort",
                           @"author": @"Hazem El-Sisy",
                           };
    callback(@[[NSNull null], info]);
}

@end

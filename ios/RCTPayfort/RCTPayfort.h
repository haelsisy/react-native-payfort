//
//  RCTPayfort.h
//  RCTPayfort
//
//  Created by Hazem El-Sisy on 1/21/18.
//  Copyright © 2018 Hazem El-Sisy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <PayFortSDK/PayFortSDK.h>

@interface RCTPayfort : NSObject <RCTBridgeModule>
@property (nonatomic) PayFortController *payFort;

- (void)initPayfort:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)getModuleInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end



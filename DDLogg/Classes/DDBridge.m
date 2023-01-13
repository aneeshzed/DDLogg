//
//  DDBridge.m
//  DatadogSDK
//
//  Created by Aneesh on 10/01/23.
//


#import "DDBridge.h"

@import DatadogObjc;

@implementation DDBridge
/**
 * This function logs the input values to DataDog Logger.
 * Also depends on the Feature flag if enabled
 * This fun checks if logging is enabled from LD or not
 */

-(void)initialize{
    DDConfigurationBuilder *builder = [DDConfiguration builderWithRumApplicationID:@"bc30b46d-e996-44fd-a87a-1d105199ea27"
                                                                       clientToken:@"pubcf6814c612ebd27e41452f7466586c77"
                                                                       environment:@"uat"];
    [builder setWithServiceName:@"app-name"];
    [builder setWithEndpoint:[DDEndpoint eu1]];
    [builder trackUIKitRUMViews];
    [builder trackUIKitRUMActions];
    [builder trackURLSessionWithFirstPartyHosts:[NSSet new]];

    [DDDatadog initializeWithAppContext:[DDAppContext new]
                        trackingConsent:[DDTrackingConsent granted]
                          configuration:[builder build]];
    
    
    
    
    
    DDGlobal.rum = [[DDRUMMonitor alloc] init];
    
}
-(void)logToRemote:(NSString*)message with:(NSDictionary*)attributes{
    NSLog(@"logToRemote called");
    NSLog(@"message = %@",message);
    NSLog(@"attributes = %@",attributes);
    DDLoggerBuilder *builder = [DDLogger builder];
    [builder sendNetworkInfo:YES];
//    [builder setWithDatadogReportingThreshold:.info];
    [builder printLogsToConsole:YES];
    
    DDLogger *logger = [builder build];
    [logger info:message attributes:attributes];
    
}
/**
 * This sets the user info on DD platform to associate
 * logs and RUM events to a specific customerID.
 *
 * Note : Sending Null resets the customer ID as this means user has logged out.
 */
-(void)setDataDogUserInfo:(BOOL)isSetUp email:(NSString*)email customerId:(int)customerId{
       
    if (isSetUp) {
        [DDDatadog setUserInfoWithId:[NSString stringWithFormat:@"%d", customerId] name:@"" email:email extraInfo:@{}];
        DDRUMMonitor *monitor = DDGlobal.rum;
        [monitor addAttributeForKey:@"usr.id" value:[NSString stringWithFormat:@"%d", customerId]];
        [monitor addAttributeForKey:@"usr.email" value:email];
        [DDGlobal setRum:monitor];
    }else{
        [DDDatadog setUserInfoWithId:@"" name:@"" email:@"" extraInfo:@{}];
        [DDGlobal setRum:[DDRUMMonitor new]];
    }
    
}

@end

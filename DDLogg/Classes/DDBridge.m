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

-(void)initializeWith:(NSString*)appID clientToken:(NSString*)token environment:(NSString*)environment{
    DDConfigurationBuilder *builder = [DDConfiguration builderWithRumApplicationID:appID
                                                                       clientToken:token
                                                                       environment:environment];
//    [builder setWithServiceName:@"app-name"];
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
        [DDDatadog setUserInfoWithId:NULL name:NULL email:NULL extraInfo:@{}];
        [DDGlobal setRum:[[DDRUMMonitor alloc] init]];
    }
}
@end

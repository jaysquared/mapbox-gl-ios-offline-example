//
//  AppDelegate.m
//  OfflineMaps
//
//  Created by Jonathan Hillebrand on 18.04.17.
//  Copyright © 2017 Jaysquared. All rights reserved.
//

#import "AppDelegate.h"
#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import "Objective-Zip.h"

@interface AppDelegate ()
@property GCDWebServer *webServer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.webServer = [[GCDWebServer alloc] init];
    
    // Add a handler to respond to PBF GET requests
    [self.webServer addDefaultHandlerForMethod:@"GET"
                                  requestClass:[GCDWebServerRequest class]
                                  processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                                      NSString *requestPath = [request.path substringFromIndex:1];
                                      
                                      NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"zip"];
                                      
                                      OZZipFile *unzipFile= [[OZZipFile alloc] initWithFileName:zipPath
                                                                                           mode:OZZipFileModeUnzip];
                                      
                                      [unzipFile locateFileInZip:requestPath];
                                      
                                      OZFileInZipInfo *info= [unzipFile getCurrentFileInZipInfo];
                                      
                                      // Expand the file in memory
                                      OZZipReadStream *read= [unzipFile readCurrentFileInZip];
                                      NSMutableData *data= [[NSMutableData alloc] initWithLength:info.length];
                                      [read readDataWithBuffer:data];
                                      [read finishedReading];
                                      
                                      return [GCDWebServerDataResponse responseWithData:data contentType:@"application/x-protobuf"];
                                  }];
    
    // Start server on port 8080
    [self.webServer startWithPort:8080 bonjourName:nil];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

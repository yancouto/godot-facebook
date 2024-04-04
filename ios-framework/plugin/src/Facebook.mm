//
//  Facebook.mm
//
//  Created by DrMoriarty on 11.02.19.
//
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "./Facebook.hpp"
@import FBSDKCoreKit;
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>
#import <sys/utsname.h>

FacebookPlugin::FacebookPlugin()
{
}

FacebookPlugin::~FacebookPlugin()
{
}

void FacebookPlugin::_init()
{
}

void FacebookPlugin::init(const String& key, const String& clientToken, const String& appName) {
    [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    [FBSDKSettings.sharedSettings setAppID:[NSString stringWithUTF8String:key.utf8().get_data()]];
    [FBSDKSettings.sharedSettings setClientToken:[NSString stringWithUTF8String:clientToken.utf8().get_data()]];
    [FBSDKSettings.sharedSettings setDisplayName:[NSString stringWithUTF8String:appName.utf8().get_data()]];

}

void FacebookPlugin::logEvent(const String& event) {
    NSString *event_name = [NSString stringWithUTF8String:event.utf8().get_data()];
    [FBSDKAppEvents.shared logEvent:event_name];
}

void FacebookPlugin::logEventValue(const String& event, double value) {
    NSString *event_name = [NSString stringWithUTF8String:event.utf8().get_data()];
    [FBSDKAppEvents.shared logEvent:event_name valueToSum:value];
}

void FacebookPlugin::_bind_methods()
{
    ClassDB::bind_method(D_METHOD("_init"), &FacebookPlugin::_init);
    ClassDB::bind_method(D_METHOD("init"), &FacebookPlugin::init);
    ClassDB::bind_method(D_METHOD("log_event"), &FacebookPlugin::logEvent);
    ClassDB::bind_method(D_METHOD("log_event_value"), &FacebookPlugin::logEventValue);
}

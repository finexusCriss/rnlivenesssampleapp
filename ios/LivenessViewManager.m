//
//  LivenessViewManager.m
//  bringSwiftUIToReactNative2
//
//  Created by Chong Jhuang Hung on 06/11/2023.
//
#import <Foundation/Foundation.h>
#import <React/RCTUtils.h>
#import "React/RCTViewManager.h"
#import <UIKit/UIKit.h>
#import <React/RCTUIManager.h>
@interface RCT_EXTERN_MODULE(LivenessViewManager, RCTViewManager)
- (dispatch_queue_t)methodQueue
{
 return dispatch_queue_create("com.amazonaws.faceliveness.cameracapturequeue", DISPATCH_QUEUE_SERIAL);
}
@end

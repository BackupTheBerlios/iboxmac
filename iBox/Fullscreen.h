#import <Foundation/Foundation.h> 
#import <AppKit/AppKit.h> 
#import <Cocoa/Cocoa.h> 
@interface NSApplication (ASKAFullScreen) 
- (NSWindow *)beginFullScreen; 
- (void)endFullScreen; 
@end 

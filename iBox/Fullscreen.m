#import "Fullscreen.h" 
NSWindow *fsWindow; 
@implementation NSApplication (ASKAFullScreen) 
- (NSWindow *)beginFullScreen 
{ fsWindow = [ 
[NSWindow alloc] 
initWithContentRect:[[NSScreen mainScreen] frame] 
styleMask:NSBorderlessWindowMask 
backing:NSBackingStoreBuffered 
defer:NO]; 
NSView *fsView=[[NSView alloc] initWithFrame:[fsWindow frame]]; 
[fsWindow setContentView:fsView]; 
NSImageView *fsImage = [[NSImageView alloc] initWithFrame:[fsView frame]]; 
[fsView addSubview:fsImage]; 
[fsWindow setBackgroundColor:[NSColor blackColor]]; 
[NSMenu setMenuBarVisible:0]; 
[fsWindow makeKeyAndOrderFront:fsWindow]; 
return fsWindow; 
} 
- (void)endFullScreen 
{ [NSMenu setMenuBarVisible:1]; 
[fsWindow close]; 
} 
@end
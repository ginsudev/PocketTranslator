#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#pragma mark - SpringBoard

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;
@property (nonatomic,readonly) NSString * displayName;
@end

@interface SpringBoard : UIApplication
@end

@interface SBFTouchPassThroughViewController : UIViewController
@end

@interface SBFTouchPassThroughWindow : UIWindow
- (instancetype)initWithScreen:(UIScreen *)arg1 debugName:(NSString *)arg2; // iOS <= 14
- (instancetype)initWithScreen:(id)arg0 role:(id)arg1 debugName:(id)arg2 ; // iOS > 15
@end

#pragma mark - Private

@interface UIViewController (Private)
- (BOOL)_canShowWhileLocked;
@end

@interface UIWindow (Private)
- (void)_setSecure:(BOOL)arg1;
@end

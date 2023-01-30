#import "PocketTranslator.h"

@implementation PocketTranslator

#pragma mark - Non-CAML approach

// Icon of your module
- (UIImage *)iconGlyph {
    return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

// Selected color of your module
- (UIColor *)selectedColor {
    return [UIColor blueColor];
}

#pragma mark - End Non-CAML approach

// Current state of your module
- (BOOL)isSelected {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"PocketTranslator.isPresented"];
}

- (void)setSelected:(BOOL)selected {
    [super refreshState];
    if (selected) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PocketTranslator.isPresented"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PocketTranslator.Present" object:nil];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PocketTranslator.isPresented"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PocketTranslator.Dismiss" object:nil];
    }
}

@end

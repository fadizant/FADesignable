//
//  NSString+FATextDirection.h
//  FADesignable
//
//  Created by Fadi Abuzant on 7/20/18.
//

#import <Foundation/Foundation.h>

/**
 * `FATextDirection` indicates text directionality, such as Neutral, Left-to-Right, and Right-to-Left
 */
typedef NS_ENUM(NSUInteger, FATextDirectionEnum) {
    /**
     * `FATextDirectionEnumNeutral` indicates text with no directionality
     */
    FATextDirectionEnumNeutral = 0,
    
    /**
     * `FATextDirectionEnumLeftToRight` indicates text left-to-right directionality
     */
    FATextDirectionEnumLeftToRight,
    
    /**
     * `FATextDirectionEnumRightToLeft` indicates text right-to-left directionality
     */
    FATextDirectionEnumRightToLeft,
};

/**
 * `NSString (FATextDirection)` is an NSString category that is used to infer the text directionality of a string.
 */
@interface NSString (FATextDirection)

/**
 *  Inspects the string and makes a best guess at text directionality.
 *
 *  @return the inferred text directionality of this string.
 */
- (FATextDirectionEnum)getBaseDirection;

- (NSString *)language;

@end

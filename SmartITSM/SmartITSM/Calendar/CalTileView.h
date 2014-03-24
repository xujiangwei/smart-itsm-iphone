/*
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>

typedef enum {
    CalTileTypeRegular   = 0,
    CalTileTypeAdjacent  = 1 << 0,
    CalTileTypeToday     = 1 << 1,
    CalTileTypeFirst     = 1 << 2,
    CalTileTypeLast      = 1 << 3,
    CalTileTypeDisable   = 1 << 4,
    CalTileTypeMarked    = 1 << 5,
} CalTileType;

typedef enum {
    CalTileStateNone = 0,
    CalTileStateSelected,
    CalTileStateHighlighted,
    CalTileStateInRange,
    CalTileStateLeftEnd,
    CalTileStateRightEnd,
} CalTileState;

@interface CalTileView : UIView
{
    CGPoint origin;
}

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) CalTileState state;
@property (nonatomic, assign) CalTileType type;
@property (nonatomic, getter = isMarked) BOOL marked;
@property (nonatomic, getter = isToday) BOOL today;
@property (nonatomic, getter = isFirst) BOOL first;
@property (nonatomic, getter = isLast) BOOL last;

- (void)resetState;
- (BOOL)isToday;
- (BOOL)isFirst;
- (BOOL)isLast;
- (BOOL)isDisable;
- (BOOL)belongsToAdjacentMonth;

@end

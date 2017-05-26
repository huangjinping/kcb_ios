//
//  CopyLineLable.h
//  copyLineLable
//
//  Created by YF on 14-11-12.
//  Copyright (c) 2014年 崔金平. All rights reserved.
//
#import <UIKit/UIKit.h>


//struct LinkMessay {
//    NSString *urlString,
//    NSRange range,
//    NSString *title
//};

@class CopyLineLable;
@protocol YFCopyableLableDelegate <NSObject>

- (NSString *)stringToCopyForCopyableLabel:(CopyLineLable *)copyableLabel;
- (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(CopyLineLable *)copyableLabel;

@end

@protocol YFLineLableDelegate <NSObject>

- (void)label:(CopyLineLable*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex withBlogIndex:(NSInteger)blogIndex;
- (void)label:(CopyLineLable*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex withBlogIndex:(NSInteger)blogIndex;
- (void)label:(CopyLineLable*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex withBlogIndex:(NSInteger)blogIndex;
- (void)label:(CopyLineLable*)label didCancelTouch:(UITouch*)touch withBlogIndex:(NSInteger)blogIndex;

@end

@interface CopyLineLable : UILabel

@property (nonatomic, assign) BOOL copyingEnabled; // Defaults to YES

@property (nonatomic, weak) id<YFCopyableLableDelegate> copyableLabelDelegate;

@property(nonatomic, weak) id <YFLineLableDelegate> lineLableDelegate;

@property (nonatomic, assign) UIMenuControllerArrowDirection copyMenuArrowDirection; // Defaults to UIMenuControllerArrowDefault

// You may want to add longPressGestureRecognizer to a container view
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;


@property (nonatomic, assign) NSInteger blogIndex;


- (CFIndex)characterIndexAtPoint:(CGPoint)point;


@end

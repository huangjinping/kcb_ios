//
//  CopyLineLable.m
//  copyLineLable
//
//  Created by YF on 14-11-12.
//  Copyright (c) 2014年 崔金平. All rights reserved.
//

#import "CopyLineLable.h"
#import <CoreText/CoreText.h>

@implementation CopyLineLable




- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self addGestureRecognizer:_longPressGestureRecognizer];
    
    _copyMenuArrowDirection = UIMenuControllerArrowDefault;
    
    _copyingEnabled = YES;
    self.userInteractionEnabled = YES;
}

#pragma mark - Public

- (void)setCopyingEnabled:(BOOL)copyingEnabled
{
    if (_copyingEnabled != copyingEnabled)
    {
        [self willChangeValueForKey:@"copyingEnabled"];
        _copyingEnabled = copyingEnabled;
        [self didChangeValueForKey:@"copyingEnabled"];
        
        self.userInteractionEnabled = copyingEnabled;
        self.longPressGestureRecognizer.enabled = copyingEnabled;
    }
}

#pragma mark - Callbacks

- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.longPressGestureRecognizer)
    {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        {
            NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot become first responder", self);
            
            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
            if ([self.copyableLabelDelegate respondsToSelector:@selector(copyMenuTargetRectInCopyableLabelCoordinates:)])
            {
                [copyMenu setTargetRect:[self.copyableLabelDelegate copyMenuTargetRectInCopyableLabelCoordinates:self] inView:self];
            }
            else
            {
                [copyMenu setTargetRect:self.bounds inView:self];
            }
            copyMenu.arrowDirection = self.copyMenuArrowDirection;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return self.copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    
    if (action == @selector(copy:))
    {
        if (self.copyingEnabled)
        {
            retValue = YES;
        }
    }
    else
    {
        // Pass the canPerformAction:withSender: message to the superclass
        // and possibly up the responder chain.
        retValue = [super canPerformAction:action withSender:sender];
    }
    
    return retValue;
}

- (void)copy:(id)sender
{
    if (self.copyingEnabled)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSString *stringToCopy;
        if ([self.copyableLabelDelegate respondsToSelector:@selector(stringToCopyForCopyableLabel:)])
        {
            stringToCopy = [self.copyableLabelDelegate stringToCopyForCopyableLabel:self];
        }
        else
        {
            stringToCopy = self.text;
        }
        
        [pasteboard setString:stringToCopy];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (CFIndex)characterIndexAtPoint:(CGPoint)point {
    
    ////////
    
    NSMutableAttributedString* optimizedAttributedText = [self.attributedText mutableCopy];
    
    [self.attributedText enumerateAttribute:(NSString*)kCTParagraphStyleAttributeName inRange:NSMakeRange(0, [optimizedAttributedText length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        
        NSMutableParagraphStyle* paragraphStyle = [value mutableCopy];
        
        if ([paragraphStyle lineBreakMode] == kCTLineBreakByTruncatingTail) {
            
            [paragraphStyle setLineBreakMode:kCTLineBreakByWordWrapping];
        }
        
        [optimizedAttributedText removeAttribute:(NSString*)kCTParagraphStyleAttributeName range:range];
        [optimizedAttributedText addAttribute:(NSString*)kCTParagraphStyleAttributeName value:paragraphStyle range:range];
        
    }];
    
    ////////
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        return NSNotFound;
    }
    
    CGRect textRect = [self textRect];
    
    if (!CGRectContainsPoint(textRect, point)) {
        return NSNotFound;
    }
    
    // Offset tap coordinates by textRect origin to make them relative to the origin of frame
    point = CGPointMake(point.x - textRect.origin.x, point.y - textRect.origin.y);
    // Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
    point = CGPointMake(point.x, textRect.size.height - point.y);
    
    //////
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)optimizedAttributedText);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, textRect);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [self.attributedText length]), path, NULL);
    
    if (frame == NULL) {
        CFRelease(path);
        return NSNotFound;
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    
    //NSLog(@"num lines: %d", numberOfLines);
    
    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }
    
    NSUInteger idx = NSNotFound;
    
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        // Get bounding information of line
        CGFloat ascent, descent, leading, width;
        width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = floor(lineOrigin.y - descent);
        CGFloat yMax = ceil(lineOrigin.y + ascent);
        
        // Check if we've already passed the line
        if (point.y > yMax) {
            break;
        }
        
        // Check if the point is within this line vertically
        if (point.y >= yMin) {
            
            // Check if the point is within this line horizontally
            if (point.x >= lineOrigin.x && point.x <= lineOrigin.x + width) {
                
                // Convert CT coordinates to line-relative coordinates
                CGPoint relativePoint = CGPointMake(point.x - lineOrigin.x, point.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                
                break;
            }
        }
    }
    
    CFRelease(frame);
    CFRelease(path);
    
    return idx;
}

#pragma mark --

- (CGRect)textRect {
    
    CGRect textRect = [self textRectForBounds:self.bounds limitedToNumberOfLines:self.numberOfLines];
    textRect.origin.y = (self.bounds.size.height - textRect.size.height)/2;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        textRect.origin.x = (self.bounds.size.width - textRect.size.width)/2;
    }
    if (self.textAlignment == NSTextAlignmentRight) {
        textRect.origin.x = self.bounds.size.width - textRect.size.width;
    }
    
    return textRect;
}


#pragma mark --

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];
    
    [self.lineLableDelegate label:self didBeginTouch:touch onCharacterAtIndex:index withBlogIndex:self.blogIndex];
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];
    
    [self.lineLableDelegate label:self didMoveTouch:touch onCharacterAtIndex:index withBlogIndex:self.blogIndex];
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];
    
    [self.lineLableDelegate label:self didEndTouch:touch onCharacterAtIndex:index withBlogIndex:self.blogIndex];
    
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    [self.lineLableDelegate label:self didCancelTouch:touch withBlogIndex:self.blogIndex];
    [super touchesCancelled:touches withEvent:event];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

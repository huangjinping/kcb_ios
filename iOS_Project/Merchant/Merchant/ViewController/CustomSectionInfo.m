//
//  CustomSectionInfo.m
//  CLEnterpriseIM
//
//  Created by Wendy on 14-8-7.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import "CustomSectionInfo.h"

@implementation CustomSectionInfo
@synthesize sectionTitle;
@synthesize open;
@synthesize infoArray;
@synthesize indexPaths;
- (id)initWithTitle:(NSString *)title open:(BOOL)isOpened infoArray:(NSArray *)infoArr indexPaths:(NSArray *)paths
{
    if (self = [super init]) {
        sectionTitle = title;
        open = isOpened;
        infoArray = [[NSMutableArray alloc] initWithArray:infoArr];
        indexPaths = [[NSMutableArray alloc] initWithArray:paths];
    }

    return self;
}

@end

//
//  CustomSectionInfo.h
//  CLEnterpriseIM
//
//  Created by Wendy on 14-8-7.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomSectionInfo : NSObject
@property (strong, nonatomic) NSString *sectionTitle;
@property (nonatomic, assign) BOOL open;
@property (strong, nonatomic) NSMutableArray *indexPaths;
@property (strong, nonatomic) NSMutableArray *infoArray;

- (id)initWithTitle:(NSString *)title open:(BOOL)isOpened infoArray:(NSArray *)infoArr indexPaths:(NSArray *)paths;
@end

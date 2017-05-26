//
//  AppPathUtil.h
//  yuan2yuan
//
//  Created by WeiHan on 7/16/15.
//  Copyright (c) 2015 cooperlink. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *GetDocumentDirectoryPath();

NSString *GetCachesPath();

BOOL IsFileExists(NSString *filepath);

BOOL DeleteFileAtPath(NSString *filepath);

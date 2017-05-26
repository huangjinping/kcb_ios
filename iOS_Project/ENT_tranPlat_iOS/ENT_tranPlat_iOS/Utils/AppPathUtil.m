//
//  AppPathUtil.m
//  yuan2yuan
//
//  Created by WeiHan on 7/16/15.
//  Copyright (c) 2015 cooperlink. All rights reserved.
//

#import "AppPathUtil.h"

NSString *GetDocumentDirectoryPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if (paths && paths.count > 0) {
        return paths[0];
    }
    
    return nil;
}

NSString *GetCachesPath(){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    if (paths && paths.count > 0) {
        return paths[0];
    }
    
    return nil;
}

BOOL IsFileExists(NSString *filepath)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filepath];
}

BOOL DeleteFileAtPath(NSString *filepath)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filepath error:nil];
}

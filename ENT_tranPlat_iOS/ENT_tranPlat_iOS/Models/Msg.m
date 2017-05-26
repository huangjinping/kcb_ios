//
//  Msg.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "Msg.h"

@implementation Msg


- (id)initWithMsg_ID:(NSString*)msg_ID
            msg_time:(NSString*)msg_time
           msg_title:(NSString*)msg_title
         msg_content:(NSString*)msg_content
     msg_read_status:(NSString*)msg_read_status
        msg_classify:(NSString*)msg_classify
         andMsg_user:(NSString*)msg_user{
    if (self = [super init]) {
        _msg_ID = [[NSString alloc] initWithString:msg_ID];
        _msg_time = [[NSString alloc] initWithString:msg_time];
        _msg_title = [[NSString alloc] initWithString:msg_title];
        _msg_content = [[NSString alloc] initWithString:msg_content];
        _msg_read_status = [[NSString alloc] initWithString:msg_read_status];
        _msg_classify = [[NSString alloc] initWithString:msg_classify];
        _msg_user = [[NSString alloc] initWithString:msg_user];
    }
    return self;
}

- (void)addToDB{
    [[DataBase sharedDataBase] insertMsg:self];
}

- (void)updateToDB{
    [[DataBase sharedDataBase] updateMsg:self];
}
@end

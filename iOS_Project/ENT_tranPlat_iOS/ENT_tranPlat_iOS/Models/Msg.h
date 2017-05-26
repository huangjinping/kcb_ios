/********************************************
 创建：20141231 闫燕
 功能：用户通知（消息）对应的model
********************************************/


#import <Foundation/Foundation.h>

@interface Msg : NSObject


/***************************************************************
 1、msg_ID（消息在服务器的id）
 2、msg_time（消息在服务器的标记时间）
 3、msg_title(消息标题)
 4、msg_content(消息内容)
 5、msg_read_status （消息读取状态【已读、未读】）
 6、msg_classify（消息类别）
 7、msg_user（消息用户）
 ***************************************************************/

@property (nonatomic, retain)   NSString        *msg_ID;
@property (nonatomic, retain)   NSString        *msg_time;
@property (nonatomic, retain)   NSString        *msg_title;
@property (nonatomic, retain)   NSString        *msg_content;
@property (nonatomic, retain)   NSString        *msg_read_status;
@property (nonatomic, retain)   NSString        *msg_classify;
@property (nonatomic, retain)   NSString        *msg_user;


- (id)initWithMsg_ID:(NSString*)msg_ID
            msg_time:(NSString*)msg_time
           msg_title:(NSString*)msg_title
         msg_content:(NSString*)msg_content
     msg_read_status:(NSString*)msg_read_status
        msg_classify:(NSString*)msg_classify
         andMsg_user:(NSString*)msg_user;

- (void)addToDB;

- (void)updateToDB;
@end

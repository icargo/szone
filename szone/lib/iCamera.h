//
//  iCamera.h
//  iConMotor
//
//  Created by Mark on 14-1-14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <string>
#include <vector>
#include <map>
using namespace std;

#define CMD_SET_WIFI_NAME                           0x01
#define CMD_SET_WIFI_PASSWORD                       0x02
#define CMD_SET_WIFI_CLEAR_PASSWORD                 0x03
#define CMD_SET_REBOOT                              0x04
#define CMD_UART_SENDDATA                           0x05
#define CMD_SET_VGA                                 0x06
#define CMD_SET_QVGA                                0x07
#define CMD_UART_RECVDATA                           0x08
#define CMD_UART_SET_WIFI_NAME_RESULT               0x09
#define CMD_UART_SET_WIFI_PASSWORD_RESULT           0x0a
#define CMD_UART_CLEAR_WIFI_PASSWORD_RESULT         0x0b
#define CMD_SET_CAMERA_RESOLUTION                   0x0d
#define CMD_SET_CAMERA_RESOLUTION_RESULT            0x0e
#define CMD_SET_NULL                                0x0f
#define CMD_LIMITED                                 0x10



enum CMDRESULT
{
    CMDRESULT_SET_FAIL=0,
    CMDRESULT_SET_SUCCESS=1,
};


struct  FilePathInfo{
	string m_strName;
	string m_strFullPath;
	bool   m_bFind;	//¥”…Ë±∏±Ì÷–’“µΩ¡À¬∑æ∂.
};

struct FolderInfo
{
	FilePathInfo m_path;
	vector<FilePathInfo >m_filesPath;
};

@protocol iCameraFunDelegate <NSObject>
@optional
- (void) DidSetWifiNameResult:(unsigned char)result;
- (void) DidSetWifiPasswordResult:(unsigned char)result;
- (void) DidClearWifiPasswordResult:(unsigned char)result;
- (void) DidRebootResult:(unsigned char)result;
- (void) DidSetVGAResult:(unsigned char)result;
- (void) DidSetQVGAResult:(unsigned char)result;
- (void) DidRecvUartData:(unsigned char*)buf :(int)length;
- (void) DidLimitedResult;





@end


@interface iCamera : NSObject<iCameraFunDelegate>
{
    UIImageView *i_imgview;

    
    unsigned int saveRecordTime;
    
}

@property (assign, nonatomic)  id<iCameraFunDelegate> iCameraDelegate;


- (id)init;

- (NSString *) iCameraGetVersion;
- (void) iCameraServerStart;
- (void) iCameraServerStop;
- (void) iCameraImgPlay :(UIImageView *)imgview;
- (void) iCameraImgStop;
- (void) iCameraAudioPlay;
- (void) iCameraAudioStop;

+(NSString *)strToNsstr:(string)strName;
+(NSString *)documentsPath:(NSString *)fileName;

+ (void) ListDirInPath :(const char *)path :(map<string ,FilePathInfo>&) mapDir;
+ (void) ListFileInPath :(const char *)path :(map<string ,FilePathInfo> &)mapDir :(const char *)szExt;
+ (void) DeleteFile:(const char *)path :(bool) bDelEmptyFolder;
-(unsigned int)GetRecordTime;


+ (bool)SnapPhoto :(bool)albumflag :(bool)snapSound;

//- (void) iCameraRecStart:(const char *)FileName :(int)framerate;

- (void) iCameraRecStart;
- (void) iCameraRecStop;
- (bool) iCameraGetisRecording;

- (int) iCameraInsertCmd:(int)times :(unsigned char)cmd;
- (int) iCameraInsertCmdData: (unsigned char*)buf :(unsigned char)length :(int)times :(unsigned char)cmd;

@end


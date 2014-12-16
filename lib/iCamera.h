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

#define KEY1 0x01
#define KEY2 0x02
#define KEY3 0x04
#define KEY4 0x08
#define KEY5 0x10
#define KEY6 0x20
#define KEY7 0x40
#define KEY8 0x80

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

@protocol FuncDelegate <NSObject>
@optional
- (void) DidKey1;
- (void) DidKey2;
- (void) DidKey3;
- (void) DidKey4;
- (void) DidKey5;
- (void) DidKey6;
- (void) DidKey7;
- (void) DidKey8;
- (void) DidUpdateImg;
@end


@interface iCamera : NSObject<FuncDelegate>
{
    UIImageView *i_imgview;
    UISlider *sliderBrightness;
    UISlider *sliderContrast;
    UISlider *sliderHue;
    UISlider *sliderSaturation;
    UISlider *sliderSharpness;
    UISlider *sliderGain;
    
    int minimumValBrightness;
    int maximumValBrightness;
    int defaultValBrightness;
    int stepValBrightness;
    int curValBrightness;
    
    int set_curValBrightness;
    
    int minimumValContrast;
    int maximumValContrast;
    int defaultValContrast;
    int stepValContrast;
    int curValContrast;
    
    int set_curValContrast;
    
    
    int minimumValHue;
    int maximumValHue;
    int defaultValHue;
    int stepValHue;
    int curValHue;
    
    int set_curValHue;
    
    
    int minimumValSaturation;
    int maximumValSaturation;
    int defaultValSaturation;
    int stepValSaturation;
    int curValSaturation;
    
    int set_curValSaturation;
    
    
    int minimumValSharpness;
    int maximumValSharpness;
    int defaultValSharpness;
    int stepValSharpness;
    int curValSharpness;
    
    int set_curValSharpness;
    
    
    int minimumValGain;
    int maximumValGain;
    int defaultValGain;
    int stepValGain;
    int curValGain;
    
    int set_curValGain;
    
    bool setCameraParamflag;
    bool getCameraParamflag;
    
    
    unsigned int saveRecordTime;
    
    unsigned char keyStatus;
}

@property (assign, nonatomic)  id<FuncDelegate> iCameraDelegate;


- (id)init;

- (NSString *) iCameraGetVersion;
- (void) iCameraServerStart;
- (void) iCameraServerStop;
- (void) iCameraImgPlay :(UIImageView *)imgview;
- (void) iCameraImgStop;
- (void) iCameraAudioPlay;
- (void) iCameraAudioStop;

- (void) iCameraCameraParamServerStart :(UISlider *)slider_Brightness :(UISlider *)slider_Contrast :(UISlider *)slider_Hue :(UISlider *)slider_Saturation :(UISlider *)slider_Sharpness :(UISlider *)slider_Gain;

- (void) iCameraCameraSetAllParam:(float)val_Brightness :(float)val_Contrast :(float)val_Hue :(float)val_Saturation :(float)val_Sharpness :(float)val_Gain;


- (void) iCameraCameraParamServerStop;


- (bool)iCameraResetParam;



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
- (bool) iCameraSetWifiName: (unsigned char *)name;
- (bool) iCameraSetWifiPassword: (unsigned char *)password;
- (bool) iCameraSetWifiClearPassword;
- (bool) iCameraSetReboot;
- (bool) iCameraSetOpenSerial;
- (bool) iCameraSetCloseSerial;
- (void) iCameraKeyDetectStart;
- (void) iCameraKeyDetectStop;
- (void) iCameraKeyStatus:(unsigned char)status;
- (unsigned char) iCameraGetKeyStatus;




- (bool) iCameraSetCameraResolution: (int)width :(int)height :(int) fps;
- (bool) iCameraGetCameraResolution: (unsigned char *)resolutionList;
- (bool) iCameraAddBrightness;
- (bool) iCameraSubBrightness;
- (bool) iCameraAddContrast;
- (bool) iCameraSubContrast;
- (bool) iCameraAddGain;
- (bool) iCameraSubGain;
- (bool) iCameraAddStaturation;
- (bool) iCameraSubStaturation;
- (bool) iCameraAddSharpness;
- (bool) iCameraSubSharpness;
- (void) iCameraGetImageWidth:(unsigned int*)width Height:(unsigned int*)height;


- (bool) iCameraGetCameraBrightness: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraContrast: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraHue: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraGain: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraStaturation: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraSharpness: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraGamma: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraWhiteBalanceTemperature: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;
- (bool) iCameraGetCameraBacklightCompensation: (int *)minimumVal :(int *)maximumVal :(int *) defaultVal :(int *) stepVal :(int *) curVal;


- (bool)iCameraAddCameraBrightness;
- (bool)iCameraAddCameraContrast;
- (bool)iCameraAddCameraHue;
- (bool)iCameraAddCameraGain;
- (bool)iCameraAddCameraSaturation;
- (bool)iCameraAddCameraSharpness;
- (bool)iCameraAddCameraWhiteBalanceTemperature;
- (bool)iCameraAddCameraBacklightCompensation;

- (bool)iCameraSubCameraBrightness;
- (bool)iCameraSubCameraContrast;
- (bool)iCameraSubCameraHue;
- (bool)iCameraSubCameraGain;
- (bool)iCameraSubCameraSaturation;
- (bool)iCameraSubCameraSharpness;
- (bool)iCameraSubCameraGamma;
- (bool)iCameraSubCameraWhiteBalanceTemperature;
- (bool)iCameraSubCameraBacklightCompensation;
- (bool)iCameraGetFuncKeyVal :(unsigned char *)value :(int *)length;



@end


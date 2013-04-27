//
//  SoundView.m
//  Sound
//
//  Created by jiayi on 13-4-10.
//  Copyright (c) 2013年 jiayi. All rights reserved.
//

#import "SoundView.h"
#import "lame.h"

@implementation SoundView
@synthesize player,Text;
@synthesize recordedFile,recorderButton,YESButton,NOButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    [player release];
    [recordedFile release];
    [super dealloc];
}

- (void)audio_PCMtoMP3
{
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    NSString *cafFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
        
    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
    
    
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil])
    {
        NSLog(@"删除");
    }

    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);

    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {

    }
    [self performSelectorOnMainThread:@selector(Tomp3Over) withObject:nil waitUntilDone:NO]; 
    [pool release];
}
-(void)Tomp3Over
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [recorderButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [recorderButton addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    NSLog(@"%@",path);
    self.recordedFile = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
    NSLog(@"%@",recordedFile);
    
    YESButton.hidden = YES;
    NOButton.hidden = YES;
    recorderButton.hidden = NO;
    
    CGAffineTransform at = CGAffineTransformMakeRotation(30.0*M_PI/180.0);
    [Text setTransform:at];
    
    CALayer *contentLayer = [Text layer];
    contentLayer.anchorPoint = CGPointMake(0.5,0.5);
	// Do any additional setup after loading the view.
}

-(void)touchDown
{
    NSLog(@"==%@==",recordedFile);
    Text.text = @"松开完成录音";
    session = [AVAudioSession sharedInstance];
    session.delegate = self;
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    /*
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                                         [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                                        [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                                                         [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
                                                        nil];
     */
    //录音设置
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    
    recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:settings error:nil];
    [recorder prepareToRecord];
    [recorder record];
    [settings release];
}
-(void)touchUp
{
    YESButton.hidden = NO;
    NOButton.hidden = NO;
    recorderButton.hidden = YES;
    
    Text.text = @"是否上传";
    [recorder stop];
    [NSThread detachNewThreadSelector:@selector(audio_PCMtoMP3) toTarget:self withObject:nil];
    if(recorder)
    {
        [recorder release];
        recorder = nil;
    }
    NSString *cafFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    
    NSError *playerError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[[NSURL alloc] initFileURLWithPath:cafFilePath] autorelease] error:&playerError];
    self.player = audioPlayer;
    player.volume = 100.0f;
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    player.delegate = self;
    [audioPlayer release];
    [player play];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

}



@end

//
//  AudioController.m
//  ATBasicSounds
//
//  Created by Audrey M Tam on 22/03/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "AudioController.h"
@import AVFoundation;

@interface AudioController () <AVAudioPlayerDelegate>
@property (strong, nonatomic) AVAudioSession *audioSession;
@property (strong, nonatomic) AVAudioPlayer *backgroundMusicPlayer;
@property (assign) BOOL backgroundMusicPlaying;
@property (assign) BOOL backgroundMusicInterrupted;
@property (assign) SystemSoundID pewPewSound;

@end

@implementation AudioController

#pragma mark - Public
- (instancetype)init
{
    self = [super init];
    if (self) {
        //[self configureAudioSession];
        //[self configureAudioPlayer];
        //[self configureSystemSound];
    }
    return self;
}

- (void)tryPlayMusic {
	
	if (self.backgroundMusicPlaying || [self.audioSession isOtherAudioPlaying]) {
        return;
    }
      //[self.backgroundMusicPlayer prepareToPlay];
    //[self.backgroundMusicPlayer play];
     self.backgroundMusicPlaying = NO;
}

- (void)playSystemSound {
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath: soundPath]), &soundID);
    AudioServicesPlaySystemSound (soundID);
    //AudioServicesPlaySystemSound(self.pewPewSound);
}

#pragma mark - AVAudioPlayerDelegate methods

- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player {
    
	self.backgroundMusicInterrupted = YES;
	self.backgroundMusicPlaying = NO;
}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player withOptions:(NSUInteger) flags{
    
      [self tryPlayMusic];
      self.backgroundMusicInterrupted = NO;
}

@end

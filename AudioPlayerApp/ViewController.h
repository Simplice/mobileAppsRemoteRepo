//
//  ViewController.h
//  AudioPlayerApp
//
//  Created by Simplice Tchoupkoua on 07.12.12.
//  Copyright (c) 2012 Simplice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h> // this librairy is important for all Apps with music player

/*
 To use PickeView it is important and necessary to implement the protocole UIPickerViewDataSource and UIPickerViewDelegate
 */
@interface ViewController : UIViewController <UIPickerViewDataSource , UIPickerViewDelegate, AVAudioPlayerDelegate>
// notre ViewController doit implémenter les protocoles entre lec crochets <>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (strong, nonatomic) NSMutableArray *myPlayListe;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *dureeTotaleDuSong;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)volume:(id)sender;

@end

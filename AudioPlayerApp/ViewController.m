//
//  ViewController.m
//  AudioPlayerApp
//
//  Created by Simplice Tchoupkoua on 07.12.12.
//  Copyright (c) 2012 Simplice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize player, myPlayListe, dureeTotaleDuSong, timer;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *music1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"myReggae", @"title", @"My own Song", @"interpreter", nil];
    NSDictionary *music2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Alone", @"title", @"Claude Kelly", @"interpreter", nil];
    NSDictionary *music3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Only one night", @"title", @"Claude Kelly", @"interpreter", nil];
    NSDictionary *music4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Number One", @"title", @"Jamie Foxx", @"interpreter", nil];
    NSDictionary *music5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Number One Fan", @"title", @"Plies", @"interpreter", nil];
    NSDictionary *music6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"thank You", @"title", @"jamelia et singuila", @"interpreter", nil];
    
    myPlayListe = [[NSMutableArray alloc] initWithObjects:music1, music2, music3, music4, music5, music6, nil];
    
    NSDictionary *initSong = [self.myPlayListe objectAtIndex:0];
    [self registerSongToPlay:[initSong objectForKey:@"title"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registerSongToPlay: (NSString *) songTitle {
    // 1. get the path of the mp3 file
    NSString *path = [[NSBundle mainBundle] pathForResource:songTitle ofType:@"mp3"];
    // 2. get the URL of the mp3 file
    NSURL *url = [NSURL fileURLWithPath:path];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    // 3. show the duration of the song
    long longueurDuSong = [self.player duration];
    self.dureeTotaleDuSong.text = [NSString stringWithFormat:@"Durée totale: %i Secondes", (int)longueurDuSong];
    // 4 ProgressView to show how long the song is gonna play
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(progressViewAktualisieren) userInfo:nil repeats:YES];
}

-(void) progressViewAktualisieren {
    float durationTotal = self.player.duration;
    float currentTime = self.player.currentTime;
    [self.progressBar setProgress:currentTime / durationTotal];
}

#pragma mark - picker view methods
// cette methode définit le nombre de colonnes dans le Pickerview
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// cette methode définit le nombre d'éléments(lignes) affichés dans le Picker
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [myPlayListe count];
}
// cette methode retourne les valeurs à afficher dans le pickerview. ces valeurs sont extraites de myArrayListe
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *currentObject = [myPlayListe objectAtIndex:row];
    return [currentObject objectForKey:@"title"];
}
// cette methode actualise notre label avec la valeur selectionée dans le pickerview
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSDictionary *currentObject = [myPlayListe objectAtIndex:row];
    NSString *selectedSong = [currentObject objectForKey:@"title"];
    // if the player is in used, then stop it before starting playing the new selected song.
    if ([self.player isPlaying]) {
        [self.player stop];
    }
    [self registerSongToPlay:selectedSong];
    [self.player play];
}

#pragma mark - AVFundation Music-Player methods
- (IBAction)play:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [player play];
}

- (IBAction)stop:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [player stop];
}

- (IBAction)volume:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UISlider *slider = sender;
    [player setVolume:slider.value];
}

/*****************************************************************************************************************************
 Cette methode provient de AVAudioPlayerDelegate, pour cette raison il faut ajouter ce protocole dans le fichier .h
 ****************************************************************************************************************************/
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self.timer invalidate];
}

@end

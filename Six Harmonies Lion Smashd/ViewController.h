//
//  ViewController.h
//  Six Harmonies Lion Smashd
//
//  Created by Louis Agars-Smith on 05/06/2015.
//  Copyright (c) 2015 Louis Agars-Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController {
    
    AVAudioPlayer *player;
    AVAudioPlayer *player2;
    
}

-(IBAction)Contact:(id)sender;
-(IBAction)openFB:(id)sender;
-(IBAction)openYT:(id)sender;
-(IBAction)openWeb:(id)sender;
-(IBAction)gameCenter:(id)sender;
-(IBAction)Game:(id)sender;

@end


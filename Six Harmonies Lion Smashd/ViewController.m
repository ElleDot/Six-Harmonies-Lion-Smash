//
//  ViewController.m
//  Six Harmonies Lion Smashd
//
//  Created by Louis Agars-Smith on 05/06/2015.
//  Copyright (c) 2015 Louis Agars-Smith. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL gameCenterEnabled;

@property (nonatomic, strong) NSString *leaderboardIdentifier;

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;

-(void)authenticateLocalPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self authenticateLocalPlayer];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"Menu"
                                         ofType:@"mp3"]];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.numberOfLoops = -1;
    
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"Game"
                                          ofType:@"mp3"]];
    player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    player2.numberOfLoops = -1;
    
    _gameCenterEnabled = NO;
    _leaderboardIdentifier = @"hiscs";
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [player play];
    [player2 stop];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Game:(id)sender {
    
    [player stop];
    
    [player2 play];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"How to play"
                                                    message:@"\nTap red lions to gain points, avoid yellows!\n\nGrab the falling lion chaser mask as many times as you can.\n\nHit flying Stuart for a score bonus.\n\nGet the biggest combo you can on Nathan!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

-(IBAction)Contact:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact Information"
                                                    message:@"\nTo contact us and/or get a booking, please visit us by tapping one of the three buttons at the bottom left of the Main Menu.\n\nOr email us at: nccma@gmx.co.uk"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

-(IBAction)openWeb:(id)sender {
    
    NSURL *myURL = [NSURL URLWithString:@"http://www.nccma.co.uk/six_harmonies_lion_dance_crew.htm"];
    [[UIApplication sharedApplication] openURL:myURL];
    
}

-(IBAction)openYT:(id)sender {
    
    NSURL *myURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=BxIx86IPBl0"];
    [[UIApplication sharedApplication] openURL:myURL];
    
}

-(IBAction)openFB:(id)sender {
    
    NSURL *myURL = [NSURL URLWithString:@"https://www.facebook.com/pages/Six-Harmonies-Lion-Dance-Crew/221648164642783?fref=ts"];
    [[UIApplication sharedApplication] openURL:myURL];
    
}

-(void)authenticateLocalPlayer{
    // Instantiate a GKLocalPlayer object to use for authenticating a player.
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            // If it's needed display the login view controller.
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                // If the player is already authenticated then indicate that the Game Center features can be used.
                _gameCenterEnabled = YES;
                
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        _leaderboardIdentifier = @"hiscs";
                    }
                }];
            }
            
            else{
                _gameCenterEnabled = NO;
            }
        }
    };
}

-(IBAction)gameCenter:(id)sender {
    
    [self showLeaderboardAndAchievements:YES];
    
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    // Init the following view controller object.
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    // Set self as its delegate.
    gcViewController.gameCenterDelegate = self;
    
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = _leaderboardIdentifier;
    
    // Finally present the view controller.
    [self presentViewController:gcViewController animated:YES completion:nil];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)unwindToViewController:(UIStoryboardSegue *)segue {
    
    ViewController *source= segue.sourceViewController;
    
}

@end

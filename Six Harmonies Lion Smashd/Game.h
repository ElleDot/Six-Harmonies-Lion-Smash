//
//  Game.h
//  
//
//  Created by Louis Agars-Smith on 05/06/2015.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <GameKit/GameKit.h>

NSInteger Score;
NSInteger Taps;
float timeMax;
NSInteger targX;
NSInteger targY;
NSInteger targXX;
NSInteger highScoreNumber;
NSInteger targXY;
int comboTap;

@interface Game : UIViewController {
    
    IBOutlet UIButton *startButton;
    NSTimer *Stutimer;
    NSTimer *Timer;
    NSTimer *kTimer;
    NSTimer *confirmTimer;
    IBOutlet UIImageView *readySteadyGo;
    IBOutlet UIButton *stuartImage;
    IBOutlet UIButton *redLion;
    IBOutlet UIButton *yellowLion;
    IBOutlet UILabel *scoreAddLabel;
    IBOutlet UIImageView *youLose;
    IBOutlet UIButton *kettleBell;
    IBOutlet UILabel *finalScoreLabel;
    IBOutlet UILabel *highScoreAchieved;
    IBOutlet UILabel *highScoreLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIButton *bottomLeftImage;
    IBOutlet UIButton *confirmButton;
    IBOutlet UIButton *exitButton;
    
}

-(IBAction)startButtonPressed:(id)sender;
-(IBAction)exitButtonPressed:(id)sender;
-(void)Lose;

@end

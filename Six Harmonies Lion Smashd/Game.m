//
//  Game.m
//  
//
//  Created by Louis Agars-Smith on 05/06/2015.
//
//

#import "Game.h"

@interface Game ()

@property CALayer *pathLayer;
@property (nonatomic, strong) NSString *leaderboardIdentifier;

@end

@implementation Game

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    exitButton.hidden = NO;
    confirmButton.hidden = YES;

    // Do any additional setup after loading the view.
    
    //highScoreNumber = 0;
    //[[NSUserDefaults standardUserDefaults] setInteger:highScoreNumber forKey:@"high"];
    // Reset high score to 0
    
    stuartImage.hidden = YES;
    
    highScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"high"];
    
    NSNumber *highScoreNumberDisplay = @(highScoreNumber);
    
    highScoreLabel.text = [NSString localizedStringWithFormat:@"High Score: %@", highScoreNumberDisplay];
    
    finalScoreLabel.center = CGPointMake(384, 1100);
    highScoreAchieved.center = CGPointMake(384, 1100);
    kettleBell.center = CGPointMake(768, 1200);
    
    bottomLeftImage.transform = CGAffineTransformMakeRotation(0.2);
    bottomLeftImage.center = CGPointMake(500, 500);
    
    youLose.hidden = YES;
    _leaderboardIdentifier = @"hiscs";
    
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:_leaderboardIdentifier];
    score.value = highScoreNumber;
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startButtonPressed:(id)sender {
    
    finalScoreLabel.center = CGPointMake(384, 1100);
    highScoreAchieved.center = CGPointMake(384, 1100);
    kettleBell.center = CGPointMake(768, 1200);
    
    bottomLeftImage.transform = CGAffineTransformMakeRotation(0.2);
    redLion.transform = CGAffineTransformMakeRotation(-0.2);
    bottomLeftImage.center = CGPointMake(-100, 1100);
    
    highScoreAchieved.hidden = YES;
    youLose.hidden = YES;
    
    Score = 0;
    Taps = 0;
    timeMax = 5;
    
    scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
    
    readySteadyGo.alpha = 1.0;
    readySteadyGo.image = [UIImage imageNamed:@"Ready.png"];
    
    stuartImage.hidden = YES;
    redLion.hidden = YES;
    yellowLion.hidden = YES;
    readySteadyGo.hidden = NO;
    startButton.hidden = YES;
    bottomLeftImage.hidden = NO;
    youLose.hidden = YES;
    youLose.center = CGPointMake(384, -128);
    
    CABasicAnimation *readyPulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    readyPulse.duration= 0.7;
    readyPulse.toValue =[NSNumber numberWithFloat:0.5];
    readyPulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    readyPulse.autoreverses= YES;
    readyPulse.repeatCount= 1;
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            [self steadyFlash];
        }];
    [readySteadyGo.layer addAnimation:readyPulse forKey:@"readyPulse"];
    } [CATransaction commit];
    
}

-(void)steadyFlash {

    readySteadyGo.image = [UIImage imageNamed:@"Set.png"];
    
    CABasicAnimation *steadyPulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    steadyPulse.duration= 0.7;
    steadyPulse.toValue =[NSNumber numberWithFloat:0.5];
    steadyPulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    steadyPulse.autoreverses= YES;
    steadyPulse.repeatCount= 1;
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            [self goFlash];
        }];
    [readySteadyGo.layer addAnimation:steadyPulse forKey:@"steadyPulse"];
    } [CATransaction commit];
    
}

-(void)goFlash{
    
    Stutimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(Stuart) userInfo:nil repeats:YES];
    
    kTimer = [NSTimer scheduledTimerWithTimeInterval:9 target:self selector:@selector(kettleBellMethod) userInfo:nil repeats:YES];
    
    readySteadyGo.image = [UIImage imageNamed:@"Go.png"];
    
    CABasicAnimation *goPulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    goPulse.duration= 1;
    goPulse.toValue =[NSNumber numberWithFloat:2];
    goPulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    goPulse.autoreverses= YES;
    goPulse.repeatCount= 1;
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{readySteadyGo.alpha = 0.0;} completion:nil];
            
        }];
        [readySteadyGo.layer addAnimation:goPulse forKey:@"goPulse"];
    } [CATransaction commit];
    
    redLion.hidden = NO;
    startButton.hidden = YES;
    Timer = [NSTimer scheduledTimerWithTimeInterval:timeMax target:self selector:@selector(Lose) userInfo:nil repeats:NO];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0,910.0)];
    [path addLineToPoint:CGPointMake(768, 910.0)];
    
    targX = arc4random() %618;
    if (targX < 75) {
        targX = 75;
    }
    if (targX > 550) {
        targX = 550;
    }
    targY = arc4random() %850;
    if (targY < 75) {
        targY = 75;
    }
    if (targY > 800) {
        targY = 800;
    }
    
    scoreAddLabel.center = redLion.center;
    
    redLion.center = CGPointMake(targX, targY);
    
    [self.pathLayer removeAnimationForKey:@"strokeEnd"];
    
    if (self.pathLayer == nil) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0.0,910.0)];
        [path addLineToPoint:CGPointMake(768.0, 910.0)];
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.frame = self.view.bounds;
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor = [[UIColor redColor] CGColor];
        pathLayer.fillColor = nil;
        pathLayer.lineWidth = 20;
        pathLayer.lineJoin = kCALineJoinBevel;
        
        [self.view.layer addSublayer:pathLayer];
        
        self.pathLayer = pathLayer;
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = timeMax;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses= YES;
    animation.repeatCount = HUGE_VAL;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = [NSNumber numberWithFloat:0.785398163];
    
    redLion.transform = CGAffineTransformMakeRotation(-0.392699082);
    
    [redLion.layer addAnimation:animation forKey:@"90rotation"];
    
    CABasicAnimation *animations = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animations.duration = 1;
    animations.fillMode = kCAFillModeForwards;
    animations.autoreverses= YES;
    animations.repeatCount = HUGE_VAL;
    animations.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animations.toValue = [NSNumber numberWithFloat:-0.785398163];
    
    yellowLion.transform = CGAffineTransformMakeRotation(0.392699082);
    
    [yellowLion.layer addAnimation:animations forKey:@"90rotation"];

    
    
}



-(IBAction)redLionTapped:(id)sender {
    
    UIColor *red = [UIColor redColor];
    
    [self -> scoreAddLabel setTextColor:red];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses= YES;
    animation.repeatCount = HUGE_VAL;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = [NSNumber numberWithFloat:0.785398163];
    
    redLion.transform = CGAffineTransformMakeRotation(-0.392699082);
    
    [redLion.layer addAnimation:animation forKey:@"90rotation"];
    
    int scoreAdd;
    
    [Timer invalidate];
    
    yellowLion.hidden = YES;
    
    scoreAddLabel.hidden = NO;
    scoreAddLabel.center = redLion.center;
    
    Taps = Taps + 1;
    
    if (Taps >= 0 && Taps < 25) {
        scoreAdd = 200;
    }
    else if (Taps >= 25 && Taps < 50) {
        scoreAdd = 400;
    }
    else if (Taps >= 50 && Taps < 75) {
        scoreAdd = 600;
    }
    else if (Taps >= 75 && Taps < 100) {
        scoreAdd = 800;
    }
    else {
        scoreAdd = 1000;
    }
    
    scoreAddLabel.text = [NSString stringWithFormat:@"+%i", scoreAdd];
    Score = Score + scoreAdd;
    [self Score];
    
    targX = arc4random() %618;
    if (targX < 75) {
        targX = 75;
    }
    if (targX > 550) {
        targX = 550;
    }
    targY = arc4random() %850;
    if (targY < 75) {
        targY = 75;
    }
    if (targY > 800) {
        targY = 800;
    }
    
    redLion.center = CGPointMake(targX, targY);
    
    int spawnBad = arc4random() % 3;
    
    if (spawnBad == 2) {
        targXX = arc4random() %618;
        if (targXX < 75) {
            targXX = 75;
        }
        if (targXX > 550) {
            targXX = 550;
        }
        targXY = arc4random() %850;
        if (targXY < 75) {
            targXY = 75;
        }
        if (targXY > 800) {
            targXY = 800;
        }
        yellowLion.hidden = NO;
        yellowLion.center = CGPointMake(targXX, targXY);
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = 1;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses= YES;
        animation.repeatCount = HUGE_VAL;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.toValue = [NSNumber numberWithFloat:-0.785398163];
        
        yellowLion.transform = CGAffineTransformMakeRotation(0.392699082);
        
        [yellowLion.layer addAnimation:animation forKey:@"90rotation"];
    }
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    theAnimation.duration= 0.1;
    theAnimation.repeatCount= 1;
    theAnimation.autoreverses= YES;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    theAnimation.fromValue =[NSNumber numberWithFloat:0];
    theAnimation.toValue =[NSNumber numberWithFloat:-50];
    
    
    timeMax = 5 - (Taps * 0.03);
    
    if (timeMax <= 0.5) {
        timeMax = 0.5;
    }
    
    [scoreAddLabel.layer addAnimation:theAnimation forKey:@"animateLayer"];
    
    [self.pathLayer removeAnimationForKey:@"strokeEnd"];
    
    if (self.pathLayer == nil) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0.0,910.0)];
        [path addLineToPoint:CGPointMake(768.0, 910.0)];
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.frame = self.view.bounds;
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor = [[UIColor redColor] CGColor];
        pathLayer.fillColor = nil;
        pathLayer.lineWidth = 20;
        pathLayer.lineJoin = kCALineJoinBevel;
        
        [self.view.layer addSublayer:pathLayer];
        
        self.pathLayer = pathLayer;
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = timeMax;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    Timer = [NSTimer scheduledTimerWithTimeInterval:timeMax target:self selector:@selector(Lose) userInfo:nil repeats:NO];
    
}

-(IBAction)yellowLionTapped:(id)sender {
    
    UIColor *yellow = [UIColor yellowColor];
    
    [self -> scoreAddLabel setTextColor:yellow];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses= YES;
    animation.repeatCount = HUGE_VAL;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = [NSNumber numberWithFloat:-0.785398163];
    
    redLion.transform = CGAffineTransformMakeRotation(0.392699082);
    
    [redLion.layer addAnimation:animation forKey:@"90rotation"];
    
    int scoreTake;
    
    if (Taps >= 0 && Taps < 25) {
        scoreTake = 400;
    }
    else if (Taps >= 25 && Taps < 50) {
        scoreTake = 800;
    }
    else if (Taps >= 50 && Taps < 75) {
        scoreTake = 1200;
    }
    else if (Taps >= 75 && Taps < 100) {
        scoreTake = 1600;
    }
    else {
        scoreTake = 2000;
    }
    
    if (Taps <= 2) {
        Taps = 0;
    }
    else {
     Taps = Taps - 3;
    }
    
    [Timer invalidate];
    
    yellowLion.hidden = YES;
    
    scoreAddLabel.hidden = NO;
    scoreAddLabel.center = CGPointMake(yellowLion.center.x, yellowLion.center.y);
    scoreAddLabel.text = [NSString stringWithFormat:@"-%i", scoreTake];
    Score = Score - scoreTake;
    [self Score];
    
    targX = arc4random() %618;
    if (targX < 75) {
        targX = 75;
    }
    if (targX > 550) {
        targX = 550;
    }
    targY = arc4random() %850;
    if (targY < 75) {
        targY = 75;
    }
    if (targY > 800) {
        targY = 800;
    }
    
    redLion.center = CGPointMake(targX, targY);
    
    int spawnBad = arc4random() % 3;
    
    if (spawnBad == 2) {
        targXX = arc4random() %618;
        if (targXX < 75) {
            targXX = 75;
        }
        if (targXX > 550) {
            targXX = 550;
        }
        targXY = arc4random() %850;
        if (targXY < 75) {
            targXY = 75;
        }
        if (targXY > 800) {
            targXY = 800;
        }
        yellowLion.hidden = NO;
        yellowLion.center = CGPointMake(targXX, targXY);
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = 1;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses= YES;
        animation.repeatCount = HUGE_VAL;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.toValue = [NSNumber numberWithFloat:-0.785398163];
        
        yellowLion.transform = CGAffineTransformMakeRotation(0.392699082);
        
        [yellowLion.layer addAnimation:animation forKey:@"90rotation"];
        
    }
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    theAnimation.duration= 0.1;
    theAnimation.repeatCount= 1;
    theAnimation.autoreverses= YES;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    theAnimation.fromValue =[NSNumber numberWithFloat:0];
    theAnimation.toValue =[NSNumber numberWithFloat:-50];
    
    timeMax = 5 - (Taps * 0.03);
    
    if (timeMax <= 0.5) {
        timeMax = 0.5;
    }
    
    [scoreAddLabel.layer addAnimation:theAnimation forKey:@"animateLayer"];
    
    [self.pathLayer removeAnimationForKey:@"strokeEnd"];
    
    if (self.pathLayer == nil) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0.0,910.0)];
        [path addLineToPoint:CGPointMake(768.0, 910.0)];
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.frame = self.view.bounds;
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor = [[UIColor redColor] CGColor];
        pathLayer.fillColor = nil;
        pathLayer.lineWidth = 20;
        pathLayer.lineJoin = kCALineJoinBevel;
        
        [self.view.layer addSublayer:pathLayer];
        
        self.pathLayer = pathLayer;
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = timeMax;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
    Timer = [NSTimer scheduledTimerWithTimeInterval:timeMax target:self selector:@selector(Lose) userInfo:nil repeats:NO];
    
    CABasicAnimation *scoreBadPulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scoreBadPulse.duration= 0.5;
    scoreBadPulse.toValue =[NSNumber numberWithFloat:0.5];
    scoreBadPulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scoreBadPulse.autoreverses= YES;
    scoreBadPulse.repeatCount= 1;
    
    [scoreLabel.layer addAnimation:scoreBadPulse forKey:@"scoreBadPulse"];
    
}

-(void)kettleBellMethod {
    
    kettleBell.hidden = NO;
    
    int kettleBellEnd = arc4random() %3;
    
    if (kettleBellEnd == 0) {
        kettleBell.center = CGPointMake(184, -100);
        CGPoint kettleBellPoint = CGPointMake(184, 1124);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        kettleBell.center = kettleBellPoint;
        [UIView commitAnimations];
    }
    else if (kettleBellEnd == 1) {
        kettleBell.center = CGPointMake(384, -100);
        CGPoint kettleBellPoint = CGPointMake(384, 1124);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        kettleBell.center = kettleBellPoint;
        [UIView commitAnimations];
    }
    else {
        kettleBell.center = CGPointMake(584, -100);
        CGPoint kettleBellPoint = CGPointMake(584, 1124);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        kettleBell.center = kettleBellPoint;
        [UIView commitAnimations];
    }
    
}

-(void)Stuart {
    
    int stuChance = arc4random() % 2;
    
    NSLog(@"Stu called %i", stuChance);
    
    stuartImage.center = CGPointMake(900, 500);
    
    if (stuChance == 0) {
        
        stuartImage.hidden = NO;
        
        int stuFlyEnd = arc4random() %3;
        
        if (stuFlyEnd == 0) {
            CGPoint stuEndPoint = CGPointMake(-200, 200);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            stuartImage.center = stuEndPoint;
            [UIView commitAnimations];
        }
        else if (stuFlyEnd == 1) {
            CGPoint stuEndPoint = CGPointMake(-200, 500);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            stuartImage.center = stuEndPoint;
            [UIView commitAnimations];
        }
        else {
            CGPoint stuEndPoint = CGPointMake(-200, 800);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            stuartImage.center = stuEndPoint;
            [UIView commitAnimations];
        }
        
    }
    
    else {
        [self bottomLeftImageCalled];
    }
    
}

-(void)bottomLeftImageCalled {
    
    bottomLeftImage.hidden = NO;
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    theAnimation.duration= 3;
    theAnimation.repeatCount= 1;
    theAnimation.autoreverses= YES;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    theAnimation.toValue = [NSNumber numberWithFloat:-280];
    
    CABasicAnimation *theAnimation2;
    theAnimation2 =[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    theAnimation2.duration= 3;
    theAnimation2.repeatCount= 1;
    theAnimation2.autoreverses= YES;
    theAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    theAnimation2.toValue = [NSNumber numberWithFloat:170];
    
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            comboTap = 0;
            bottomLeftImage.hidden = YES;
        }];
        [bottomLeftImage.layer addAnimation:theAnimation forKey:@"anim"];
        [bottomLeftImage.layer addAnimation:theAnimation2 forKey:@"anim2"];
    } [CATransaction commit];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint p =[((UITouch *)[touches anyObject]) locationInView:self.view];
    CGRect r = [stuartImage.layer.presentationLayer frame];
    CGRect k = [kettleBell.layer.presentationLayer frame];
    CGRect nath = [bottomLeftImage.layer.presentationLayer frame];
    BOOL contains= CGRectContainsPoint(r, p);
    if(contains == YES) {
        [self stuPressed];
        NSLog(@"s Touched");
        scoreAddLabel.center = CGPointMake(p.x, p.y);
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        theAnimation.duration= 0.1;
        theAnimation.repeatCount= 1;
        theAnimation.autoreverses= YES;
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        theAnimation.fromValue =[NSNumber numberWithFloat:0];
        theAnimation.toValue =[NSNumber numberWithFloat:-50];
        [scoreAddLabel.layer addAnimation:theAnimation forKey:@"animateLayer"];
    }
    BOOL containsK = CGRectContainsPoint(k, p);
    if (containsK == YES) {
        [self kettleBellTapped];
        NSLog(@"k Touched");
        scoreAddLabel.center = CGPointMake(p.x, p.y);
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        theAnimation.duration= 0.1;
        theAnimation.repeatCount= 1;
        theAnimation.autoreverses= YES;
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        theAnimation.fromValue =[NSNumber numberWithFloat:0];
        theAnimation.toValue =[NSNumber numberWithFloat:-50];
        [scoreAddLabel.layer addAnimation:theAnimation forKey:@"animateLayer"];
    }
    BOOL containsB = CGRectContainsPoint(nath, p);
    if (containsB == YES) {
        [self bottomLeftImageTapped];
    }
    
}

-(void)bottomLeftImageTapped {
    
    comboTap = comboTap + 1;
    
    UIColor *white = [UIColor whiteColor];
    
    [self -> scoreAddLabel setTextColor:white];
    
    scoreAddLabel.text = [NSString stringWithFormat:@"Combo %i!", comboTap];
    Score = Score + (comboTap * 100);
    NSNumber *scoreDisplay = @(Score);
    scoreLabel.text = [NSString localizedStringWithFormat:@"Score: %@", scoreDisplay];
    
    float comboTapAnim = (comboTap / 10) + 1;
    
    CABasicAnimation *theAnimationd;
    theAnimationd=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimationd.duration= 0.1;
    theAnimationd.repeatCount= 1;
    theAnimationd.autoreverses= YES;
    theAnimationd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    theAnimationd.toValue = [NSNumber numberWithFloat:comboTapAnim];
    scoreAddLabel.center = CGPointMake(384, 500);
    
    [self.view addSubview: scoreAddLabel];

    
    [scoreAddLabel.layer addAnimation:theAnimationd forKey:@"animateLayerd"];
    
}

-(void)stuPressed {
    
    scoreAddLabel.text = [NSString stringWithFormat:@"Score Multiplied!"];
    Score = Score + (25 * (Score / 100));
    NSNumber *scoreDisplay = @(Score);
    
    UIColor *green = [UIColor greenColor];
    
    [self -> scoreAddLabel setTextColor:green];
    
    scoreLabel.text = [NSString localizedStringWithFormat:@"Score: %@", scoreDisplay];
    stuartImage.hidden = YES;
}

-(IBAction)exitButtonPressed:(id)sender {
    
    exitButton.hidden = YES;
    confirmButton.hidden = NO;
    
    confirmTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(confirmReset) userInfo:nil repeats:NO];
    
}

-(void)confirmReset {
    
    exitButton.hidden = NO;
    confirmButton.hidden = YES;
    
}

-(void)kettleBellTapped {
    
    int scoreAddNumber;
    
    UIColor *blue = [UIColor colorWithRed:0 green:255 blue:255 alpha:1];
    
    [self -> scoreAddLabel setTextColor:blue];
    
    Taps = Taps + 1;
    
    if (Taps >= 0 && Taps < 25) {
        scoreAddNumber = 500;
    }
    else if (Taps >= 25 && Taps < 50) {
        scoreAddNumber = 1000;
    }
    else if (Taps >= 50 && Taps < 75) {
        scoreAddNumber = 1500;
    }
    else if (Taps >= 75 && Taps < 100) {
        scoreAddNumber = 2000;
    }
    else {
        scoreAddNumber = 2500;
    }
    
    scoreAddLabel.text = [NSString stringWithFormat:@"+%i", scoreAddNumber];
    Score = Score + scoreAddNumber;
    
    NSNumber *scoreNumber = @(Score);
    
    scoreLabel.text = [NSString localizedStringWithFormat:@"Score: %@", scoreNumber];
    
}

-(void)Lose {
    
    [Stutimer invalidate];
    [kTimer invalidate];
    
    stuartImage.center = CGPointMake(1000, 1100);
    redLion.center = CGPointMake(1000, 1100);
    yellowLion.center = CGPointMake(1000, 1100);
    kettleBell.center = CGPointMake(1000, 1100);
    
    startButton.hidden = NO;
    redLion.hidden = YES;
    yellowLion.hidden = YES;
    youLose.hidden = NO;
    scoreAddLabel.hidden = YES;
    kettleBell.hidden = YES;
    CGPoint youLosePoint = CGPointMake(384, 300);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    youLose.center = youLosePoint;
    [UIView commitAnimations];
    
    [startButton setAlpha:0.0];
    
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{startButton.alpha = 1.0;} completion:nil];
    
    CGPoint finalScorePoint = CGPointMake(384, 578);
    CGPoint highScorePoint = CGPointMake(384, 628);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    finalScoreLabel.center = finalScorePoint;
    highScoreAchieved.center = highScorePoint;
    [UIView commitAnimations];
    
    NSNumber *scoreNumber = @(Score);
    
    finalScoreLabel.text = [NSString localizedStringWithFormat:@"Final Score: %@", scoreNumber];
    
    if (Score > highScoreNumber) {
        highScoreAchieved.hidden = NO;
        highScoreNumber = Score;
        NSNumber *scoreNumber = @(highScoreNumber);
        highScoreLabel.text = [NSString localizedStringWithFormat:@"High Score: %@", scoreNumber];
        [[NSUserDefaults standardUserDefaults] setInteger:highScoreNumber forKey:@"high"];
        [self reportScore];
    }
    
}

-(void)reportScore{
    // Create a GKScore object to assign the score and report it as a NSArray object.
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:_leaderboardIdentifier];
    score.value = highScoreNumber;
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(void)Score {
    NSNumber *scoreDisplay = @(Score);
    [self.view addSubview: scoreLabel];
    scoreLabel.center = CGPointMake(384, 967);
    scoreLabel.text = [NSString localizedStringWithFormat:@"Score: %@", scoreDisplay];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [segue sourceViewController];
    // Pass the selected object to the new view controller.
}

@end

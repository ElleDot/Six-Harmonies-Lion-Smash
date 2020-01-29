//
//  AboutViewController.m
//  Six Harmonies Lion Smash
//
//  Created by Louis Agars-Smith on 17/06/2015.
//  Copyright (c) 2015 Louis Agars-Smith. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    redLion.transform = CGAffineTransformMakeRotation(0.392699082);
    yellowLion.transform = CGAffineTransformMakeRotation(-0.392699082);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ShortAudioPlayVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/9.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ShortAudioPlayVC.h"
#import "ShortAudioTool.h"

@interface ShortAudioPlayVC ()

@end

@implementation ShortAudioPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[ShortAudioTool sharedShortAudioTool] playMp3WithName:@"enemy3_down.mp3"];
}

@end

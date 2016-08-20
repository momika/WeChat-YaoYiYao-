//
//  ViewController.m
//  微信摇一摇动画
//
//  Created by peter on 16/8/20.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.layer.contents = (id)[UIImage imageNamed:@"ShakeforsongBgshade"].CGImage;
}

/**
 *  开始摇一摇
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    /**
     *  隐式动画
     */
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.duration = 0.4;
    animation.autoreverses = YES;
    //终点位置：translation是相对于原来的位置移动多少位移。
    animation.toValue = @(-50);
    [self.topImageView.layer addAnimation:animation forKey:nil];
    
    animation.toValue = @(50);
    [self.bottomImageView.layer addAnimation:animation forKey:nil];
    
    
    //播放系统的音频文件，需要传入一个SoundID，所有的SoundID参考http://iphonedevwiki.net/index.php/AudioServices
    SystemSoundID soundID;
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shake_sound_male.mp3" ofType:nil]];
    
    //创建一个自定义SoundID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    //播放
    AudioServicesPlaySystemSound(soundID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

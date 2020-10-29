//
//  CZPlayerToolBar.m
//  A01_传智音乐
//
//  Created by apple on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZPlayerToolBar.h"
#import "UIButton+CZ.h"
#import "CZMusic.h"
#import "UIImage+CZ.h"
#import "CZMusicTool.h"
#import "NSString+CZ.h"

@interface CZPlayerToolBar()



@property (weak, nonatomic) IBOutlet UIImageView *singerImgView;//歌手头像
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;//歌曲的名字
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;//歌手的名字

@property (weak, nonatomic) IBOutlet UISlider *timeSlider;


@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;//总时间
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;//当前播放的时间


@property(strong,nonatomic)CADisplayLink *link;//定时器

@property(assign,nonatomic,getter=isDragging)BOOL dragging;//是否正在拖拽

@end

@implementation CZPlayerToolBar


-(CADisplayLink *)link{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    
    return _link;
}

+(instancetype)playerToolBar{
    return [[[NSBundle mainBundle] loadNibNamed:@"CZPlayerToolBar" owner:nil options:nil] lastObject];
}


#pragma mark 设置当前播放的音乐，并显示数据
-(void)setPlayingMusic:(CZMusic *)playingMusic{
    _playingMusic = playingMusic;
    
    //歌手的头像,歌手的头像是圆形，有边框
    UIImage *cicleImage = [UIImage circleImageWithName:playingMusic.singerIcon borderWidth:1.0 borderColor:[UIColor yellowColor]];
    self.singerImgView.image = cicleImage;
    //歌曲名
    self.musicNameLabel.text = playingMusic.name;
    //歌手名
    self.singerNameLabel.text = playingMusic.singer;
    
    //设置总时间
    double duration = [CZMusicTool sharedCZMusicTool].player.duration;
    self.totalTimeLabel.text = [NSString getMinuteSecondWithSecond:duration];
    
    //设置slider的最大值
    self.timeSlider.maximumValue = duration;
    
    //重置slider的播放时间
    self.timeSlider.value = 0;
    
    //头像复位
    self.singerImgView.transform = CGAffineTransformIdentity;
    

}
- (IBAction)playBtnClick:(UIButton *)btn {
    
    //更改播放状态
    self.playing = !self.playing;
    if (self.playing) {//播放音乐
        NSLog(@"播放音乐");
        //1.如果是播放的状态，按钮的图片更改为暂停的状态
        [btn setNBg:@"playbar_pausebtn_nomal" hBg:@"playbar_pausebtn_click"];

        
        [self notifyDelegateWithBtnType:BtnTypePlay];
        }else{//暂停音乐
        NSLog(@"暂停音乐");
        //2.如果当前是暂停的状态，按钮的图片更改为播放的状态
        [btn setNBg:@"playbar_playbtn_nomal" hBg:@"playbar_playbtn_click"];
            
            [self notifyDelegateWithBtnType:BtnTypePause];
    }
    
}


#pragma mark 上一首
- (IBAction)previousBtnClick:(id)sender {
    [self notifyDelegateWithBtnType:BtnTypePrevious];
    //恢复头像的位置
    self.singerImgView.transform = CGAffineTransformIdentity;
}


#pragma mark  下一首
- (IBAction)nextBtnClick:(id)sender {
    [self notifyDelegateWithBtnType:BtnTypeNext];
    
    //恢复头像的位置
    self.singerImgView.transform = CGAffineTransformIdentity;
}



//通知代理
-(void)notifyDelegateWithBtnType:(BtnType)btnType{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(playerToolBar:btnClickWithType:)]) {
        [self.delegate playerToolBar:self btnClickWithType:btnType];
    }

}



-(void)awakeFromNib{
    //设置slider 按钮的图片
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"playbar_slider_thumb"] forState:UIControlStateNormal];
    
    //开启定时器
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

-(void)dealloc{
    //移除定时器
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
#pragma mark 更新进度条
-(void)update{
    
    if (self.isPlaying && self.isDragging == NO) {//如果正在播放，才有需要做下面的操作
        //1.更新进度条
        double currentTime = [CZMusicTool sharedCZMusicTool].player.currentTime;
        self.timeSlider.value = currentTime;
        
        //2.更新时间
        self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:currentTime];
        
        //3.头像转动
        CGFloat angle = M_PI_4 / 60;
        self.singerImgView.transform = CGAffineTransformRotate(self.singerImgView.transform, angle);
    }
   
}

#pragma mark slider 点击的时候，暂停播放
- (IBAction)stopPlay:(UISlider *)sender {
    //更改拖拽的状态
    self.dragging = YES;
    
    [[CZMusicTool sharedCZMusicTool] pause];
}

#pragma mark slider拖动
- (IBAction)sliderChange:(UISlider *)sender {
    //1.播放器的进度
    [CZMusicTool sharedCZMusicTool].player.currentTime = sender.value;
    
    //2.工具条的当前时间
    self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:sender.value];
    
}


#pragma mark slider 松开手指的时候，继续播放
- (IBAction)replay:(UISlider *)sender {

    self.dragging = NO;
    
    if (self.isPlaying) {
        [[CZMusicTool sharedCZMusicTool] play];
    }
}



@end

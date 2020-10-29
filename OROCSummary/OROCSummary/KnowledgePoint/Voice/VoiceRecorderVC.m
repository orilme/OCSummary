//
//  VoiceRecorderVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/10.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "VoiceRecorderVC.h"
#import <AVFoundation/AVFoundation.h>

@interface VoiceRecorderVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 * 音频数据
 */
@property(nonatomic,strong)NSMutableArray *data;
/**
 *录音器
 */
@property(nonatomic,strong)AVAudioRecorder *recorder;

/**
 *录音器
 */
@property(nonatomic,strong)AVAudioPlayer *player;

@end

@implementation VoiceRecorderVC

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}
/**
 *开始录音
 */
- (IBAction)beginRecord:(id)sender {
    NSLog(@"%s",__func__);
    //开始录音前要准备的工作
    // 1.初始化录音器
    
    // 1.1录音文件保存的路径(docemnt + 时间)
    // doc路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 格式化时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    // 拼接录音保存的文件路径
    NSString *filePath = [doc stringByAppendingFormat:@"/%@.caf",dateStr];
    
    NSLog(@"%@",filePath);
    
    // 1.2 录音配置
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];

    //音频编码格式
    settings[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
    
    //音频采样频率
    settings[AVSampleRateKey] = @(8000.0);
    
    //音频频道
    settings[AVNumberOfChannelsKey] = @(1);
    
    //音频线性音频的位深度
    settings[AVLinearPCMBitDepthKey] = @(8);
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:filePath] settings:settings error:nil];
    
    // 2.准备录音
    [self.recorder prepareToRecord];
    
    // 3.开始录音
    [self.recorder record];
    
    // 路径保存到数据中
    [self.data addObject:filePath];
}

/**
 * 结束录音
 */
- (IBAction)endRecord:(id)sender {
    NSLog(@"%s",__func__);

    [self.recorder stop];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recorder.url error:nil];
    NSLog(@"%lf",player.duration);
    if (player.duration <= 0.5) {
        NSLog(@"时间太短");
        [self.data removeLastObject];
        return;
    }
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.data[indexPath.row] lastPathComponent];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *filePath = self.data[indexPath.row];
    NSLog(@"%@",filePath);
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];
    [self.player prepareToPlay];
    [self.player play];
}

@end

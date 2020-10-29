9. 设置音乐后台播放 •要实现后台的音乐播放有三个步骤要设置

》在didFinishLaunching方法激活音频的会话类型即可，代码如下
/*设置会话类型 AVAudioSession *session = [AVAudioSession sharedInstance]; [session setCategory:AVAudioSessionCategoryPlayback error:nil]; [session setActive:YES error:nil]; */
》在applicationDidEnterBackground方法开始后台任务，代码如下
"[application beginBackgroundTaskWithExpirationHandler:nil];
》在info.plist中添加'Required background modes'选向，然后再添加'App plays audio or streams audio/video using AirPlay'
10. 实现歌曲锁屏
•设置锁屏的音乐信息要使用MediaPlayer框架的MPNowPlayingInfoCenter类来实现，
•代码设置锁屏时的播放信息代码为[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo,nowPlayingInfo传入一个字典
/* //1.专辑名称 MPMediaItemPropertyAlbumTitle //2.歌曲 MPMediaItemPropertyTitle //3.歌手名称 MPMediaItemPropertyTitle //4.专辑图片 MPMediaItemPropertyArtwork 需要传入一个MPMediaItemArtwork对象 //5.时间 MPMediaItemPropertyPlaybackDuration */
•在didFinishLaunching添加接收远程事件代码,"一定要添加，不然无效果" //[application beginReceivingRemoteControlEvents];
11实现锁屏按钮远程事件 •在appdelegate中实现remoteControlReceivedWithEvent，来接收远程事件


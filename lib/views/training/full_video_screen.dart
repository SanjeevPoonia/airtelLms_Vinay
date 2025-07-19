
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import '../../network/loader.dart';
import '../../utils/app_theme.dart';
class FullVideoScreen extends StatefulWidget
{
  final String videoUrl;
  final bool skipVideo;
  FullVideoScreen(this.videoUrl,this.skipVideo);

  @override
  FullVideoScreenState createState()=>FullVideoScreenState();
}

class FullVideoScreenState extends State<FullVideoScreen> with WidgetsBindingObserver
{
   VideoPlayerController? _controller;
  late final chewieController;
  bool pageNavigator=false;
   AppLifecycleState? _notification;
   VideoPlayerOptions videoPlayerOptions = VideoPlayerOptions(allowBackgroundPlayback: false);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.themeColor,
      child: SafeArea(child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Padding(padding: EdgeInsets.only(top: 10,left: 15),

              child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },

                  child: Icon(Icons.close,color: Colors.black,size: 35)),

            ),


            Expanded(child:  _controller!.value.isInitialized
               ? Center(
             child: SizedBox(
                 child: AspectRatio(
                     aspectRatio: _controller!.value.aspectRatio,
                     child:

                     Chewie(
                       controller: chewieController
                     )


                   /*Stack(
                    alignment: Alignment.bottomCenter,
                    children: [

                      VideoPlayer(_controller),
                      VideoProgressIndicator(_controller, allowScrubbing: true),
                    ],
                  )*/
                 )
             ),
           )
               :


            Center(
              child: Loader(),
            )


             /*  Center(
             child: Loader(),
           ),*/)
          ],
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print(widget.videoUrl);
    print('******Playing****');

    _onControllerChange(widget.videoUrl);


 /*   _controller = VideoPlayerController.network(widget.videoUrl, videoPlayerOptions: videoPlayerOptions)
      ..initialize().then((_) {
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            _controller.play();
          }
        });
        _controller.play();
        setState(() {});
      });*/
  }

  prepareVideo() async {
    _controller=VideoPlayerController.networkUrl(
      videoPlayerOptions: videoPlayerOptions,
        Uri.parse(widget.videoUrl.toString()));
    await _controller!.initialize();

    chewieController=await ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: false,
      draggableProgressBar:widget.skipVideo?false:true
    );

    setState(() {

    });

  }

   @override
   void didChangeAppLifecycleState(AppLifecycleState state) {
     setState(() {
       _notification = state;
     });

     if(_notification==AppLifecycleState.paused)
       {
         _controller!.pause();
         setState(() {

         });
       }
   }
  Future<void> _onControllerChange(String link) async {
    if (_controller == null) {
      // If there was no controller, just create a new one
     prepareVideo();
    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = _controller;

      // Registering a callback for the end of next frame
      // to dispose of an old controller
      // (which won't be used anymore after calling setState)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController!.dispose();

        // Initing new controller
        prepareVideo();
      });

      // Making sure that controller is not used by setting it to null
      setState(() {
        _controller = null!;
      });
    }}
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller!.pause();
    _controller!.dispose();
    chewieController.dispose();

    super.dispose();
  }

}
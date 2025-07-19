import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../widgets/app_bar_widget.dart';


class WebViewPPT extends StatefulWidget
{
  final String url;
  WebViewPPT(this.url);
  PrivacyPolicyState createState()=>PrivacyPolicyState();
}
class PrivacyPolicyState extends State<WebViewPPT> {
  bool isLoading=true;
  late final WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);

          Navigator.pop(context);


          return Future.value(false);
        },
        child: Scaffold(
          body:
          /* Stack(
            children: <Widget>[
              WebViewWidget(
                controller: _controller,
              ),

              isLoading ? Center( child: CircularProgressIndicator())
                  : Stack(),
              TermsAppBar(
                onTap: () {
                  Navigator.pop(context);
                },
                showBackIc: true,
              ),

            ],
          ),*/


          Column(
            children: [

              /*   Container(
                  height: 57,
                  color: AppTheme.redColor,
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Training',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 36),
                    ],
                  ),
                ),*/

              Expanded(
                child:
                isLoading?
                Center(
                  child: Loader(),
                ):


                WebViewWidget(
                  controller: _controller,
                ),
              ),
            ],
          ),



        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.url);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = WebViewController()
    ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading=true;
            });
          },
          onPageFinished: (String url) {

            setState(() {
              isLoading=false;
            });


          },

          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
// /initialUrl: 'https://aha-me.com/aha/terms_and_conditions',

/*JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }*/
}
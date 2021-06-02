import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _link;
  bool _createlink = false;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamiclink) async {
        final Uri deeplink = dynamiclink?.link;
        if (deeplink != null) {
          Navigator.pushNamed(context, deeplink.path);
        }
      },
      onError: (OnLinkErrorException error) async {
        print(error.message);
      },
    );

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    final Uri deeplink = data?.link;
    if (deeplink != null) {
      Navigator.pushNamed(context, deeplink.path);
    }
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _createlink = true;
    });
    Uri url;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://flutterfirebaseconfig.page.link',
      link: Uri.parse('https://flutterfirebaseconfig.page.link/Hello'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.flutter_firebase_config',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.example.flutter_firebase_config',
        minimumVersion: '0',
      ),
    );

    if (short) {
      final ShortDynamicLink shortDynamicLink =
          await parameters.buildShortLink();
      url = shortDynamicLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }
    setState(() {
      _link = url.toString();
      _createlink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Dynamic Links')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed:
                          !_createlink ? () => _createDynamicLink(false) : null,
                      child: Text('Long Link')),
                  ElevatedButton(
                      onPressed:
                          !_createlink ? () => _createDynamicLink(true) : null,
                      child: Text('Short Link')),
                ],
              ),
              InkWell(
                onTap: () async {
                  if (_link != null) {
                    await launch(_link);
                  }
                },
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: _link));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Copied text')));
                },
                child: Text(_link ?? '',
                    style: const TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
        // ),
      ),
    );
  }
}

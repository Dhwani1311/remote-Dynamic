// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   RemoteConfig _remoteConfig;

//   bool isLoading = true;

//   Color _color;

//   String _string;
//   @override
//   void initState() {
//     _intialization();
//     super.initState();
//   }

//   _intialization() async {
//     if (_remoteConfig == null) {
//       _remoteConfig = await RemoteConfig.instance;

//       final Map<String, dynamic> defaults = <String, dynamic>{
//         //'new_color_enabled': false,
//         'new_strings': 'Default String'
//       };
//       await _remoteConfig.setDefaults(defaults);
//       _remoteConfig.setConfigSettings(RemoteConfigSettings(
//         fetchTimeoutMillis: 1,
//         minimumFetchIntervalMillis: 1,
//       ));

//       await _fetchValue();
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> _fetchValue() async {
//     try {
//       await _remoteConfig.fetch(expiration: Duration(seconds: 1));
//       await _remoteConfig.activateFetched();
//       print("Last Status : " + _remoteConfig.lastFetchStatus.toString());
//       print("Last fetch time : " + _remoteConfig.lastFetchTime.toString());
//       print('new colour enabled :' +
//           _remoteConfig.getBool('new_colour_enabled').toString());
//       print(
//           'new string : ' + _remoteConfig.getString('new_strings').toString());
//       setState(() {
//         _color = _remoteConfig.getBool('new_color_enabled')
//             ? Colors.lightBlueAccent
//             : Colors.lightGreen;
//         _string = _remoteConfig.getString('new_strings');
//       });
//     } catch (e) {
//       print("Error  : " + e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: isLoading
//           ? null
//           : AppBar(
//               title: Center(
//                   child: Text('Remote Config',
//                       style: TextStyle(color: _color, fontSize: 20))),
//               backgroundColor: _remoteConfig.getBool('new_color_enabled')
//                   ? Colors.black12
//                   : Colors.cyanAccent[300],
//             ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SizedBox(
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Firebase Remote Config",
//                     style: TextStyle(color: _color, fontSize: 30),
//                   ),
//                   Text(_string, style: TextStyle(color: _color, fontSize: 30)),
//                   OutlinedButton(
//                     onPressed: () => _fetchValue(),
//                     child: Text('Refresh',
//                         style: TextStyle(color: _color, fontSize: 20)),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

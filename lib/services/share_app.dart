// // Importing Packages
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:foodapp/constants.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';

// // Shares the app
// Future shareApp(BuildContext context) async {
//   try {
//     final ByteData bytes =
//         await rootBundle.load('assets/default-imgs/qr-code-register.png');
//     final Uint8List list = await bytes.buffer.asUint8List();

//     final tempDir = await getTemporaryDirectory();
//     final file =
//         await new File('${tempDir.path}/qr-code-register.png').create();
//     file.writeAsBytesSync(list);
//     String path = file.path;
//     print(path);
//     await Share.shareFiles(['${path}'], text: kShareText);
//   } catch (e) {
//     print(e);
//   }
//   // await Share.share(
//   //   kShareText,
//   //   subject: kShareSubject,
//   //   sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
//   // );
// }

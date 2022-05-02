// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class PickerSourceActionSheet extends StatelessWidget {
//   Function(ImageSource) selectImageSource;
//
//   PickerSourceActionSheet({
//     required Key key,
//     required this.selectImageSource,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isIOS) {
//       showCupertinoModalPopup(
//           context: context,
//           builder: (context) => CupertinoActionSheet(
//             actions: [
//               CupertinoActionSheetAction(
//                 child: Text('Camera'),
//                 onPressed: () {
//                   Navigator.pop(context);
//                   selectImageSource(ImageSource.camera)
//                 }),
//               CupertinoActionSheetAction(
//                 child: Text('Gallery'),
//                   onPressed: () {
//                   Navigator.pop(context);
//                   selectImageSource(ImageSource.gallery);
//               }),
//             ],
//           ),
//       );
//     } else {
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return ListView(children: [
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text('Camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   selectImageSource(ImageSource.camera);
//                   }),
//                 ListTile(
//                   leading: Icon(Icons.photo_album),
//                   title: Text('Gallery'),
//                 onTap: () {
//                     Navigator.pop(context);
//                     selectImageSource(ImageSource.gallery);
//                 }),
//             ]);
//           },
//       );
//     }
//   }
// }
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

// class Imageuploader extends StatefulWidget {
//   @override
//   _ImageUploader createState() => _ImageUploader();
// }

// class _ImageUploader extends State<Imageuploader> {
//   PlatformFile? pickedFile;

//   Future SelectFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );

//     if (result == null) return;

//     setState(() {
//       pickedFile = result.files.first;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (pickedFile != null)
//             Expanded(
//               child: Container(
//                 child: Center(
//                     child: Image.file(
//                   File(pickedFile!.path!),
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )),
//               ),
//             ),
//           ElevatedButton(onPressed: () {}, child: Text('Upload')),
//           ElevatedButton(
//               onPressed: () {
//                 SelectFile();
//               },
//               child: Text('Select')),
//         ],
//       ),
//     ));
//   }
// }

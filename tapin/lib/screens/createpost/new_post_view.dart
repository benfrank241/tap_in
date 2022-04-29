import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tapin/screens/createpost/new_post_bloc.dart';
import 'package:tapin/screens/createpost/new_post_event.dart';

import 'new_post_state.dart';

class NewPostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPostBloc(),
      child: Scaffold(
        appBar: _appBar(),
        body: SafeArea(
          //minimum: EdgeInsets.symmetric(horizontal: 20),
            child: newPostPage(context)),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text('New Post'),
    );
  }

  Widget newPostPage(BuildContext context) {
    return BlocListener<NewPostBloc, NewPostState>(
      listener: (context, state) {
        if (state.isImageSourceActionSheetVisible) {
          _showPickerSourceActionSheet(context);
        }
      },
      child: Column(
        children: [
          _image(context),
          _caption(),
          Spacer(),
          _createPostButton(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _image(BuildContext context) {
    return BlocBuilder<NewPostBloc, NewPostState>(builder: (context, state) {
      return SizedBox(
        child: Center(
          child: state.avatarPath != null
              ? Image.file(File(state.avatarPath))
              : GestureDetector(
            child: Icon(
              Icons.photo_sharp,
              size: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
            onTap: () => context.read<NewPostBloc>().add(PickImageRequest()),
          ),
        ),
      );
    });
  }

  Widget _caption() {
    return TextField(
        maxLines: null,
        decoration: InputDecoration.collapsed(
            hintText: 'Enter a caption...'));
  }

  Widget _createPostButton() {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        child: Text('Post'),
        onPressed: () {},
      ),
    );
  }

  void _showPickerSourceActionSheet(BuildContext context) {
    Function(ImageSource) selectImageSource = (imageSource) {
      context.read<NewPostBloc>().add(
          OpenImagePicker(imageSource: imageSource));
    };
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) =>
            CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    child: Text('Camera'),
                    onPressed: () {
                      Navigator.pop(context);
                      selectImageSource(ImageSource.camera);
                    }),
                CupertinoActionSheetAction(
                    child: Text('Gallery'),
                    onPressed: () {
                      Navigator.pop(context);
                      selectImageSource(ImageSource.gallery);
                    }),
              ],
            ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(children: [
            ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  selectImageSource(ImageSource.camera);
                }),
            ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  selectImageSource(ImageSource.gallery);
                }),
          ]);
        },
      );
    }
  }
}

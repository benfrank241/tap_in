// import 'package:tapin/screens/createpost/new_post_event.dart';
// import 'package:tapin/screens/createpost/new_post_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
//   NewPostBloc() : super(NewPostState());
//
//   @override
//   Stream<NewPostState> mapEventToState(NewPostEvent event) async* {
//     if (event is PickImageRequest) {
//       yield state.copyWith(isImageSourceActionSheetVisible: true);
//     }else if (event is OpenImagePicker) {
//       yield state.copyWith(isImageSourceActionSheetVisible: false);
//
//       final pickedImage = await _picker.getImage(source: event.imageSource);
//       if (pickedImage == null) return;
//       yield state.copyWith(avatarPath: pickedImage.path);
//     } else if (event is ProvideImagePath) {
//       yield state.copyWith(avatarPath: event.imagePath);
//     } else if (event is CaptionDidChange){
//       yield state.copyWith(caption: event.caption);
//     } else if (event is CreatePost) {
//       // save data and store image
//     }
//   }
// }
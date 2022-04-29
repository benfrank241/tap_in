abstract class NewPostEvent {}

class PickImageRequest extends NewPostEvent {}

class OpenImagePicker extends NewPostEvent {}

class ProvideImagePath extends NewPostEvent {
  final String imagePath;

  ProvideImagePath({required this.imagePath});
}

class CaptionDidChange extends NewPostEvent{
  final String caption;

  CaptionDidChange({required this.caption});
}

class CreatePost extends NewPostEvent {}
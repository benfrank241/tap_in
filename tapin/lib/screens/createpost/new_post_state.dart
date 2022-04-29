

import '../../api/form_submission_status.dart';

class NewPostState {
  final String avatarPath;
  final String caption;
  final FormSubmissionStatus formStatus;
  final bool isImageSourceActionSheetVisible;

  NewPostState({
    required this.avatarPath,
    required this.caption,
    this.formStatus = const InitialFormStatus(),
    this.isImageSourceActionSheetVisible = false,
  });

  NewPostState copyWith({
    required String avatarPath,
    required String caption,
    required FormSubmissionStatus formStatus,
    required bool isImageSourceActionSheetVisible,
  }) {
    return NewPostState(
      avatarPath: avatarPath ?? this.avatarPath,
      caption: caption ?? this.caption,
      formStatus: formStatus ?? this.formStatus,
      isImageSourceActionSheetVisible: isImageSourceActionSheetVisible ??
          this.isImageSourceActionSheetVisible,
    );
  }
}
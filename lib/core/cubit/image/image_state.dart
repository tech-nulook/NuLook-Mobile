part of 'image_cubit.dart';

sealed class ImageState extends Equatable {
  const ImageState();
}

final class ImageInitial extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageLoading extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageSelected extends ImageState {
  final File imageFile;

  ImageSelected(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class ImageError extends ImageState {
  final String message;

  ImageError(this.message);

  @override
  List<Object> get props => [message];
}

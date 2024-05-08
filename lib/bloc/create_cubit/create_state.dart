import 'package:equatable/equatable.dart';
import 'package:ngdemo13/models/post_model.dart';

abstract class CreateState extends Equatable {
  const CreateState();

  @override
  List<Object?> get props => [];
}

class CreateInitialState extends CreateState {}

class CreateLoadingState extends CreateState {}

class CreatedPostListState extends CreateState {
  final Post post;

  const CreatedPostListState(this.post);

  @override
  List<Object?> get props => [post];
}

class CreatedPostState extends CreateState {
  final Post title;
  final Post body;

  const CreatedPostState(this.title,this.body);

  @override
  List<Object?> get props => [title,body];
}

class CreateErrorState extends CreateState {
  final String errorMessage;

  const CreateErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo13/bloc/home_cubit/home_state.dart';
import '../../models/post_model.dart';
import '../../pages/creat_page.dart';
import '../../pages/update_page.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../create_cubit/create_cubit.dart';
import '../update_cubit/update_cubit.dart';

class HomeCubit extends Cubit <HomeState>{
  HomeCubit() : super(HomeInitialState());

 List<Post> posts = [];

  Future<void>loadPosts() async {
    emit(HomeLoadingState());

    var response = await Network.GET(Network.API_POST_LIST, Network.paramsEmpty());
    if (response != null) {
      var postList = Network.parsePostList(response);
      posts.addAll(postList);
      emit(HomePostListState(posts));
    } else {
      emit(HomeErrorState("Could not fetch posts"));
    }
    LogService.d(response!);
  }

  Future<void>deletePost(Post post) async {
    emit(HomeLoadingState());

  var response = await Network.DEL(Network.API_POST_DELETE + post.id.toString(),
      Network.paramsEmpty());
    if (response != null) {
      emit(HomeDeletePostState());
    } else {
      emit(HomeErrorState('Could not delete post'));
    }
  LogService.d(response!);
  loadPosts();
}

  Future callCreatePage(BuildContext context) async {
  bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return BlocProvider(
      create: (context)=>CreateCubit(),
        child: CreatePage());
  }));

  if (result) {
    loadPosts();
  }
}

 Future callUpdatePage(Post post,BuildContext context) async {
  bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return BlocProvider(
      create:  (context)=>UpdateCubit(),
        child: UpdatePage(post: post));
  }));

  if (result) {
    loadPosts();
  }
 }
}


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import 'create_state.dart';

class CreateCubit extends Cubit <CreateState>{
  CreateCubit() : super(CreateInitialState());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

 Future<void> creatPost(BuildContext context) async{
   emit(CreateLoadingState());

    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(userId: 1,title: title, body: body);

    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
   if(response != null){
     emit( CreatedPostListState(post));
   } else {
     emit( CreateErrorState('Could not delete post'));
   }
    LogService.d(response!);
    backToFinish(context);
  }

  backToFinish(BuildContext context){
    Navigator.of(context).pop(true);
  }

}
import 'package:bloc/bloc.dart';
import 'package:chatapp/constants/firestore-colliction.dart';
import 'package:chatapp/models/message-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<MessageModel> messageModelList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollictionMessages);
  sendMessage({required String message, required String email}) {
    try {
      messages.add({kMessage: message, kCreateAt: DateTime.now(), 'id': email});
    } on Exception catch (e) {}
  }

  getMessage() {
    messages.orderBy(kCreateAt, descending: false).snapshots().listen((event) {
      messageModelList.clear();
      for (var doc in event.docs) {
        messageModelList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(messageModelList: messageModelList));
    });
  }
}

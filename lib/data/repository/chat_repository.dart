import 'package:chatt_app/data/models/chat_room_model.dart';
import 'package:chatt_app/data/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository extends BaseRepository{

  CollectionReference get _chatTooms => firestore.collection("chatRooms");

  Future<ChatRoomModel> getOrCreateChatRoom(String currentUserId, String otherUserId) async{
     final users = [currentUserId, otherUserId]..sort();
     // abcd // xyz
     final roomId = users.join("_");

     final roomDoc = await _chatTooms.doc(roomId).get();

     if(roomDoc.exists)
     {
      return ChatRoomModel.fromFirestore(roomDoc);
     }

     final currentUserData = (await firestore.collection("users").doc(currentUserId).get()).data() as Map<String, dynamic>;
  }
}
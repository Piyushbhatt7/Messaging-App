import 'package:chatt_app/data/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository extends BaseRepository{

  CollectionReference get _chatTooms => firestore.collection("chatRooms");

  
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:wori_app/core/constants/app_assets.dart';
import 'package:wori_app/core/constants/padding.dart';
import 'package:wori_app/core/features/domain/entities/conversation/conversation_entity.dart';
import 'package:wori_app/core/features/presentation/bloc/chat/chat_event.dart';

import '../../../../constants/size_box.dart';
import '../../../../theme.dart';
import '../../bloc/chat/chat_bloc.dart';
import '../../bloc/chat/chat_state.dart';




class ChatPage extends StatefulWidget {
  final String conversationId;
  final String mate;
  final String participantImage;
  const ChatPage({super.key, required this.conversationId, required this.mate, required this.participantImage});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final storage = const FlutterSecureStorage();
  String userId = '';
  String botAiId = '00000000-0000-0000-0000-000000000000';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(LoadMessagesEvent(widget.conversationId));
    // BlocProvider.of<ChatBloc>(context).add(LoadDailyQuestionEvent(widget.conversationId));
    fetchUserId();
  }

  fetchUserId() async {
    userId = await storage.read(key: 'userId') ?? '';
    setState(() {
    });
  }

  void sendMessage() {
    final content = _messageController.text.trim();
    if(content.isNotEmpty) {
      BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(widget.conversationId, content));
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.participantImage),
            ),
            const SizedBox(width: 10),
            Text(
             " ${widget.mate}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search,color: Colors.white,),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder:(context, state){
                if(state is ChatLoadingState){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is ChatLoadedState){
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index){
                      final message = state.messages[index];
                      final isSendMessage = message.senderId == userId;
                      final isDailyQuestion = message.senderId == botAiId;

                     if(isSendMessage){
                       return _buildSendMessage(context, message.content);
                     }  else if(isDailyQuestion){
                       return _buildDailyQuestion(context, message.content);
                     }
                     else {
                        return _buildReceivedMessage(context, message.content);
                     }
                    },
                  );
                }else if(state is ChatErrorState){
                  debugPrint(state.message);
                  return Center(child: Text(state.message));
                }else{
                  return const SizedBox();
                }
              },
            ),
          ),

          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        padding: PaddingConstants.padAll14,
        decoration: BoxDecoration(
            color: DefaultColors.receiverMessage,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildSendMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
        padding: PaddingConstants.padAll14,
        decoration: BoxDecoration(
            color: DefaultColors.receiverMessage,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: PaddingConstants.padSymH10,
      margin: PaddingConstants.padAll20,
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
          ),
          SizedBoxConstants.sizedBoxW10,
           Expanded(child:TextField(
            controller:_messageController ,
            decoration: const InputDecoration(
              hintText: "Message",

              hintStyle: TextStyle(color: Colors.grey,),
              border: InputBorder.none
            ),
          )),
          SizedBoxConstants.sizedBoxW10,
          GestureDetector(
            onTap: sendMessage,
            child: const Icon(
              Icons.send,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDailyQuestion(BuildContext context, String message) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: PaddingConstants.padAll14,
        decoration: BoxDecoration(
            color: DefaultColors.dailyQuestionColor,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          "🧠 Daily Question: $message",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

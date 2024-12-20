import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wori_app/core/constants/app_assets.dart';
import 'package:wori_app/core/constants/size_box.dart';
import 'package:wori_app/core/features/presentation/bloc/contact/contact_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/contact/contact_state.dart';
import 'package:wori_app/core/features/presentation/pages/chat/chat_page.dart';
import 'package:wori_app/core/theme.dart';

import '../../../../constants/padding.dart';
import '../../bloc/contact/contact_event.dart';
import '../../bloc/conversation/conversation_bloc.dart';
import '../../bloc/conversation/conversation_event.dart';
import '../../bloc/conversation/conversation_state.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConversationBloc>(context).add(FetchConversationsEvent());
    BlocProvider.of<ContactBloc>(context).add(LoadRecentContact());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PaddingConstants.padAll08,
            child: Text(
              'Recent',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          BlocListener<ContactBloc, ContactState>(
            listener: (context, state) async {
              final contactsBloc = BlocProvider.of<ContactBloc>(context);

              if (state is ConversationReady) {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                          conversationId: state.conversationId,
                          mate: state.contact.username,
                          participantImage: state.contact.profileImage!,
                        )));
                if(res == null){
                  contactsBloc.add(FetchContacts());
                  contactsBloc.add(LoadRecentContact());
                }
              }
            },
            child:   BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                if (state is RecentContactLoaded) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.recentContacts.length,
                      itemBuilder: (context, index) {
                        final recentContact = state.recentContacts[index];
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<ContactBloc>(context).add(
                              CheckOrCreateConversation(
                                  contactId: recentContact.id,
                                  contact: recentContact),
                            );
                          },
                          child: _buildRecentContact(
                              context,
                              recentContact.username,
                              recentContact.profileImage!),
                        );
                      },
                    ),
                  );
                } else if (state is ContactError) {
                  debugPrint('Error: ${state.message}');
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('No Conversations found'));
              },
            ),
          ),

          SizedBoxConstants.sizedBoxH10,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: BlocBuilder<ConversationBloc, ConversationState>(
                builder: (context, state) {
                  if (state is ConversationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConversationsLoaded) {
                    return ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                        conversationId: conversation.id,
                                        mate: conversation.participantName,
                                        participantImage:
                                            conversation.participantImage!)));
                          },
                          child: _buildMessageTitle(
                              context,
                              conversation.lastMessage,
                              conversation.participantName,
                              conversation.participantImage!,
                              conversation.lastMessageTime.toString()),
                        );
                      },
                    );
                  } else if (state is ConversationsError) {
                    debugPrint('Error: ${state.message}');
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No Conversations found'));
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final contactBloc = BlocProvider.of<ContactBloc>(context);
          var result = await Navigator.pushNamed(context, '/contactPage');
          if (result == null) {
            contactBloc.add(LoadRecentContact());
          }
        },
        backgroundColor: DefaultColors.buttonColor,
        child: const Icon(Icons.contacts),
      ),
    );
  }

  Widget _buildMessageTitle(BuildContext context, String email, String name,
      String image, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(image),
      ),
      title: Text(name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        email,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              overflow: TextOverflow.ellipsis,
              color: Colors.grey,
            ),
      ),
      trailing: Text(
        time,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildRecentContact(BuildContext context, String name, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}

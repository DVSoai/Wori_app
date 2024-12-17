import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/contact/contact_bloc.dart';

import '../../bloc/contact/contact_event.dart';
import '../../bloc/contact/contact_state.dart';
import '../chat/chat_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Contact',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<ContactBloc, ContactState>(
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
            }
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if (state is ContactLoading) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (state is ContactLoaded) {
                return ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = state.contacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(contact.profileImage!),
                      ),
                      title: Text(contact.username, style: Theme.of(context).textTheme.bodyLarge,),
                      subtitle: Text(contact.email,style: Theme.of(context).textTheme.bodyLarge),
                      onTap: (){
                        BlocProvider.of<ContactBloc>(context).add(
                          CheckOrCreateConversation(contactId: contact.id, contact: contact),
                        );
                      },
                    );
                  },
                );
              }else if(state is ContactError){
                return Center(child: Text(state.message),);
              }
              return   Center(child: Text('No contacts found',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),);
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showAddContactDialog(BuildContext context) {
  final emailController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Add Contact',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        content: TextField(
          obscureText: false,
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter contact email',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                context.read<ContactBloc>().add(AddContacts(email: email));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

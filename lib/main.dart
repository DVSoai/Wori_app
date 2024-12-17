import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wori_app/core/features/data/datasources/auth/auth_remote_data_source.dart';
import 'package:wori_app/core/features/data/datasources/message/messages_remote_data_source.dart';
import 'package:wori_app/core/features/data/repositories/contacts/contact_repository_impl.dart';
import 'package:wori_app/core/features/data/repositories/conversation/conversations_repository_impl.dart';
import 'package:wori_app/core/features/data/repositories/message/message_repository_impl.dart';
import 'package:wori_app/core/features/domain/usecase/auth/login_use_case.dart';
import 'package:wori_app/core/features/domain/usecase/auth/register_use_case.dart';
import 'package:wori_app/core/features/domain/usecase/message/fetch_messages_use_case.dart';
import 'package:wori_app/core/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/contact/contact_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/conversation/conversation_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/chat/chat_bloc.dart';
import 'package:wori_app/core/features/presentation/pages/chat/chat_page.dart';
import 'package:wori_app/core/features/presentation/pages/contact/contact_page.dart';
import 'package:wori_app/core/features/presentation/pages/message/message_page.dart';

import 'package:wori_app/core/theme.dart';

import 'core/features/data/datasources/contacts/contact_remote_data_source.dart';
import 'core/features/data/datasources/conversation/conversations_remote_data_source.dart';
import 'core/features/data/repositories/auth/auth_repository_impl.dart';
import 'core/features/domain/usecase/contacts/add_contact_use_case.dart';
import 'core/features/domain/usecase/contacts/fetch_contact_use_case.dart';
import 'core/features/domain/usecase/conversation/check_or_create_conversation_use_case.dart';
import 'core/features/domain/usecase/conversation/fet_conversation_use_case.dart';
import 'core/features/domain/usecase/message/fetch_daily_question_use_case.dart';
import 'core/features/presentation/pages/login/login_page.dart';
import 'core/features/presentation/pages/register/register_page.dart';
import 'core/socket_service.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();

  await socketService.initSocket();
  final authRepository =
      AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationsRepository = ConversationsRepositoryImpl(
      remoteDataSource: ConversationsRemoteDataSource());
  final messageRepository = MessageRepositoryImpl(
      messagesRemoteDataSource: MessagesRemoteDataSource());
  final contactRepository = ContactRepositoryImpl(contactRemoteDataSource: ContactRemoteDataSource());
  runApp(MyApp(
    authRepository: authRepository,
    conversationsRepository: conversationsRepository,
    messageRepository: messageRepository,
    contactRepository: contactRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationsRepository;
  final MessageRepositoryImpl messageRepository;
  final ContactRepositoryImpl contactRepository;

  const MyApp(
      {super.key,
      required this.authRepository,
      required this.conversationsRepository,
      required this.messageRepository, required this.contactRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthBloc(
                  registerUseCase: RegisterUseCase(repository: authRepository),
                  loginUseCase: LoginUseCase(repository: authRepository))),
          BlocProvider(
              create: (_) => ConversationBloc(
                  fetchConversationUseCase: FetchConversationUseCase(
                      repository: conversationsRepository))),
          BlocProvider(
            create: (_) => ChatBloc(
                fetchMessagesUseCase: FetchMessagesUseCase(
                    messagesRepository: messageRepository),
              fetchDailyQuestionUseCase: FetchDailyQuestionUseCase(
                messagesRepository: messageRepository
              )
            ),
          ),
          BlocProvider(
            create: (_) => ContactBloc(
                fetchContactUseCase: FetchContactUseCase(
                    contactsRepository: contactRepository),
              addContactUseCase: AddContactUseCase(
                contactsRepository: contactRepository
              ),
              checkOrCreateConversationUseCase: CheckOrCreateConversationUseCase(
                conversationsRepository: conversationsRepository
              )
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.darkTheme,
          home: const LoginPage(),
          debugShowCheckedModeBanner: false,
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            // '/chatPage':(context) => const ChatPage(),
            '/conversationPage': (context) => const MessagePage(),
            '/contactPage': (context) => const ContactPage(),
          },
        ));
  }
}

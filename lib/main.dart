import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Components/Widgets/auth_Widgets.dart';
import 'Services/auth_Service_Adapter.dart';
import 'Services/email_Secure_Store.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Models/user_Model.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthServiceType initialAuthServiceType = AuthServiceType.firebase;

  @override
  Widget build(BuildContext context) {
    // MultiProvider for top-level services that can be created right away
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthServiceAdapter(
            initialAuthServiceType: initialAuthServiceType,
          ),
          dispose: (_, AuthService authService) => authService.dispose(),
        ),
        /*Provider<EmailSecureStore>(
          create: (_) => EmailSecureStore(
            flutterSecureStorage: FlutterSecureStorage(),
          ),
        ),*/
      ],
      child: AuthWidgetBuilder(
          builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
        return MaterialApp(
          title: 'AppFlutterFirebase',
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: AuthWidget(userSnapshot: userSnapshot),
          /*home: EmailLinkErrorPresenter.create(
            context,
            child: AuthWidget(userSnapshot: userSnapshot),
          */
        );
      }),
    );
  }
}

import 'common/widgets/custom_buttom_bar.dart';
import 'constants/global_variables.dart';
import 'features/admin/screens/admin_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/auth/services/auth_service.dart';
import 'providers/user_provider.dart';
import 'router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserPorvider()),
      ],
      child: const AmazonClone(),
    ),
  );
}

class AmazonClone extends StatefulWidget {
  const AmazonClone({super.key});

  @override
  State<AmazonClone> createState() => _AmazonCloneState();
}

class _AmazonCloneState extends State<AmazonClone> {
  AuthServiceImp authService = AuthServiceImp();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        useMaterial3: false,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserPorvider>(context).user.token.isNotEmpty
          ? Provider.of<UserPorvider>(context).user.type == 'user'
              ? const CustomUserButtomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}

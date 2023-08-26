import 'package:echo_frontend/common_widgets/loading_overlay.dart';
import 'package:echo_frontend/common_widgets/responsive_scrollable_card.dart';
import 'package:echo_frontend/constants/app_sizes.dart';
import 'package:echo_frontend/localization/string_hardcoded.dart';
import 'package:echo_frontend/pages/login_page/login_page_controller.dart';
import 'package:echo_frontend/pages/login_page/login_page_validator.dart';
import 'package:echo_frontend/routing/app_router.dart';
import 'package:echo_frontend/utils/async_value_ui.dart';
import 'package:echo_frontend/utils/string_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with LoginValidators {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _submitted = false;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(loginControllerProvider.notifier);
      final success = await controller.submit(email: email, password: password);
      if (success && mounted) {
        context.goNamed(AppRoute.home.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(loginControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    final state = ref.watch(loginControllerProvider);
    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: ResponsiveScrollableCard(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'ECHO'.hcd,
                      style: const TextStyle(
                        fontSize: Sizes.p48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH48,
                    Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) => !_submitted ? null : emailErrorText(email ?? ''),
                          textInputAction: TextInputAction.next,
                          inputFormatters: <TextInputFormatter>[
                            ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator()),
                          ],
                          decoration: InputDecoration(
                            enabled: !state.isLoading,
                            hintText: '電子郵件'.hcd,
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        gapH16,
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (password) => !_submitted ? null : passwordErrorText(password ?? ''),
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator()),
                          ],
                          decoration: InputDecoration(
                            enabled: !state.isLoading,
                            hintText: '密碼'.hcd,
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                      ],
                    ),
                    gapH48,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: state.isLoading ? null : () => _submit(),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          '登入'.hcd,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (state.isLoading) const LoadingOverlay(),
      ],
    );
  }
}

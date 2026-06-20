import 'package:alumni_network/pages/home_page.dart';
import 'package:alumni_network/pages/signUpPage.dart';
import 'package:alumni_network/widgets/custom_text_field.dart';
import 'package:alumni_network/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alumni_network/data/model/registration/signin_model.dart';
import 'package:alumni_network/data/provider/signin_notifier.dart';
import 'package:alumni_network/data/provider/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _checkIfAlreadyLoggedIn();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<void> _checkIfAlreadyLoggedIn() async {
    final bool isLoggedIn = await ref.read(authCheckProvider.future);
    if (isLoggedIn && context.mounted) {
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }
  void _btnLogin() {
    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }
    final signInData = SignInModel(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    ref.read(signInProvider.notifier).signIn(signInData);
  }
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signInProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false, 
          );
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully Login")),
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
    });
    final signinState = ref.watch(signInProvider);
    final isLoading = signinState.isLoading;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: 0.1.h,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/cover.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        _makeTitle(),
                        SizedBox(height: 30.h),
                        CustomTextField(
                          icon: Icons.email, 
                          label: "Email", 
                          controller: emailController,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          icon: Icons.lock, 
                          label: "Password", 
                          controller: passwordController, 
                          isPassword: true,
                        ),
                        SizedBox(height: 30.h),
                        isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : CustomElevatedButton(
                                text: "Login",
                                onPressed: _btnLogin,
                              ),
                        SizedBox(height: 40.h),
                        _makeDontHaveAccount(),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  Widget _makeTitle() {
    return Text(
      "Login to your account",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _makeDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: const Text(
            "Register",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
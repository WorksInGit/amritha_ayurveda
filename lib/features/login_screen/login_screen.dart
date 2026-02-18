import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/core/app_route.dart';
import 'package:amritha_ayurveda/features/home_screen/home_screen.dart';
import 'package:amritha_ayurveda/gen/assets.gen.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:amritha_ayurveda/theme/theme.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../services/size_utils.dart';
import 'package:amritha_ayurveda/core/repository.dart';

class LoginScreen extends StatefulWidget {
  static const String path = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: 'test_user');
  final passwordController = TextEditingController(text: '12345678');
  bool isPasswordVisible = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 217.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                Assets.pngs.splashBackground.path,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                          ),
                        ),

                        SvgPicture.asset(Assets.svgs.splashLogo, width: 84.h),
                      ],
                    ),
                    gapXL,

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login Or Register To Book Your Appointments',
                              style: context.poppins60024,
                            ),
                            gapXL,

                            AppTextField(
                              label: 'Email',
                              hintText: 'Enter your email',
                              controller: usernameController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            Gap(middlePadding),

                            AppTextField(
                              label: 'Password',
                              hintText: 'Enter password',
                              controller: passwordController,
                              obscureText: !isPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),

                            Gap(84.h),

                            AppButton(
                              text: 'Login',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    final response = await DataRepository.i
                                        .login(
                                          username: usernameController.text,
                                          password: passwordController.text,
                                        );

                                    if (mounted) {
                                      showSuccessMessage(
                                        response.data['message'],
                                      );

                                      if (mounted) {
                                        navigate(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          HomeScreen.path,
                                          replace: true,
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      showErrorMessage(e);
                                    }
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                }
                              },
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20.h,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: context.poppins30012,
                          children: [
                            TextSpan(
                              style: context.poppins30012,
                              text:
                                  'By creating or logging into an account you are agreeing with our ',
                            ),
                            TextSpan(
                              style: context.poppins50012.copyWith(
                                color: Color(0xFF0028FC),
                              ),
                              text: 'Terms and Conditions',
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              style: context.poppins30012,
                              text: ' and ',
                            ),
                            TextSpan(
                              style: context.poppins50012.copyWith(
                                color: Color(0xFF0028FC),
                              ),
                              text: 'Privacy Policy.',
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

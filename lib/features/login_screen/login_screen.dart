import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/gen/assets.gen.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../services/size_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String path = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'test_user');
  final _passwordController = TextEditingController(text: '12345678');
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image Section
            Stack(
              alignment: Alignment.center,
              children: [
                // Background Image
                Container(
                  height: 280.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.pngs.splashBackground.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(
                        alpha: 0.3,
                      ), // Dark overlay for better logo visibility
                    ),
                  ),
                ),
                // Logo
                SvgPicture.asset(
                  Assets.svgs.splashLogo,
                  width: 100.h,
                  height: 100.h,
                ),
              ],
            ),

            // Form Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Login Or Register To Book Your Appointments',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: const Color(0xFF333333),
                            height: 1.3,
                            fontSize: 24.fSize,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Gap(middlePadding),

                    // Email/Username Field
                    AppTextField(
                      label: 'Email',
                      hintText: 'Enter your email',
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    gapLarge,

                    // Password Field
                    AppTextField(
                      label: 'Password',
                      hintText: 'Enter password',
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
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

                    Gap(middlePadding),

                    // Login Button
                    AppButton(
                      text: 'Login',
                      onPressed: () {},
                      isLoading: false,
                    ),

                    gapXL,

                    // Terms and Conditions footer
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12.fSize,
                          color: const Color(0xFF6B7280), // Grey text
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                'By creating or logging into an account you are agreeing with our ',
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                              color: Color(0xFF006837), // Primary color link
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle T&C tap
                              },
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: const TextStyle(
                              color: Color(0xFF006837), // Primary color link
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle Privacy Policy tap
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

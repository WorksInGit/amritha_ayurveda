import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/gen/assets.gen.dart';
import 'package:amritha_ayurveda/theme/theme.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/features/login_screen/mixins/email_password_mixin.dart';

class LoginScreen extends StatefulWidget {
  static const String path = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with EmailPasswordMixin {
  @override
  void dispose() {
    emailController.dispose();
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                            ),
                            const Gap(middlePadding),

                            AppTextField(
                              label: 'Password',
                              hintText: 'Enter password',
                              controller: passwordController,
                              obscureText: !passwordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: togglePasswordVisibility,
                              ),
                              validator: passwordValidator,
                            ),

                            Gap(84.h),

                            AppButton(
                              text: 'Login',
                              onPressed: () {
                                signInWithEmailAndPassword(onSuccess: () {});
                              },
                              isLoading: loginButtonLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
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
                                color: const Color(0xFF0028FC),
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
                                color: const Color(0xFF0028FC),
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

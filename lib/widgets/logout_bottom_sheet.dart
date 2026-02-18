import 'package:amritha_ayurveda/core/token_auth_interceptor.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              Text('Logout', style: context.poppins60018),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, size: 24.r),
              ),
            ],
          ),
          Gap(10.w),
          Text('Are you sure you want to logout?', style: context.poppins40014),
          Gap(20.w),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: context.poppins50016,
              ),
              child: const Text('Logout'),
            ),
          ),
          Gap(20.w),
        ],
      ),
    );
  }
}

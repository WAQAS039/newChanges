import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/sign_in/provider/sign_in_provider.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:nour_al_quran/shared/widgets/text_field_column.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  var email = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 80.h,),
            const Text("Forgot Your Password"),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  _buildForm() {
    return Container(
      margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 50.h),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFieldColumn(titleText: "Email", controller: email, hintText: "Type Your Email",isPasswordField: false,),
            BrandButton(text: "Send", onTap: (){
              if(formKey.currentState!.validate()){
                Provider.of<SignInProvider>(context,listen: false).resetPassword(email: email.text, context: context);
              }
            }),
          ],
        ),
      ),
    );
  }
}

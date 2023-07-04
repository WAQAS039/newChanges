import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utills/app_colors.dart';

class TextFieldColumn extends StatefulWidget {
  final String titleText;
  final TextEditingController controller;
  final String hintText;
  final bool? isPasswordField;
  const TextFieldColumn(
      {Key? key,
      required this.titleText,
      required this.controller,
      required this.hintText,
      this.isPasswordField = false})
      : super(key: key);

  @override
  State<TextFieldColumn> createState() => _TextFieldColumnState();
}

class _TextFieldColumnState extends State<TextFieldColumn> {
  bool isHide = false;
  @override
  Widget build(BuildContext context) {
    var style14 = TextStyle(
        fontFamily: 'satoshi', fontSize: 14.sp, fontWeight: FontWeight.w400);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 7.h),
            child: Text(
              widget.titleText,
              style: style14,
            )),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.w),
            hintText: widget.hintText,
            hintStyle: style14,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: const BorderSide(color: AppColors.grey5)),
            // focusedBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(6.r),
            //     borderSide: const BorderSide(color: AppColors.grey5)
            // ),
            // enabledBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(6.r),
            //     borderSide: const BorderSide(color: AppColors.grey5)
            // ),
            suffixIcon: widget.isPasswordField!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                    icon:
                        Icon(isHide ? Icons.visibility_off : Icons.visibility),
                  )
                : const SizedBox.shrink(),
          ),
          obscureText: widget.isPasswordField! ? isHide : false,
          validator: (value) {
            // if(widget.isPasswordField!){
            //   return validatePassword();
            // }

            if (!widget.isPasswordField!) {
              return validateEmail();
            } else {
              return null;
            }
          },
        ),

        // widget.isPasswordField! != true ? TextFormField(
        //   controller: widget.controller,
        //   decoration: InputDecoration(
        //     hintText: widget.hintText,
        //     hintStyle: style14,
        //     suffixIcon: widget.isPasswordField! ? IconButton(
        //       onPressed: (){},
        //       icon: const Icon(Icons.visibility),
        //     ) : const SizedBox.shrink(),
        //     contentPadding: EdgeInsets.only(left: 10.w,right: 10.w),
        //     focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(6.r),
        //         borderSide: const BorderSide(color: AppColors.grey5)
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(6.r),
        //         borderSide: const BorderSide(color: AppColors.grey5)
        //     ),
        //   ),
        // ) : const SizedBox.shrink(),
        // widget.isPasswordField! ? TextFormField(
        //   obscureText: isHide,
        //   controller: widget.controller,
        //   decoration: InputDecoration(
        //     hintText: widget.hintText,
        //     hintStyle: style14,
        //     suffixIcon: widget.isPasswordField! ? IconButton(
        //       onPressed: (){
        //         setState(() {
        //           isHide = !isHide;
        //         });
        //       },
        //       icon: Icon(isHide ? Icons.visibility_off : Icons.visibility),
        //     ) : const SizedBox.shrink(),
        //     contentPadding: EdgeInsets.only(left: 10.w,right: 10.w),
        //     focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(6.r),
        //         borderSide: const BorderSide(color: AppColors.grey5)
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(6.r),
        //         borderSide: const BorderSide(color: AppColors.grey5)
        //     ),
        //   ),
        // ) : const SizedBox.shrink()
      ],
    );
  }

  validateEmail() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(widget.controller.text);
    if (widget.controller.text.isEmpty) {
      return "Required";
    } else if (!emailValid) {
      return "Not a Valid Email";
    } else {
      return null;
    }
  }

  validatePassword() {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (widget.controller.text.isEmpty) {
      return "Required";
    } else if (widget.controller.text.length < 8) {
      return "Password can't be less than 8 characters";
    } else if (!regex.hasMatch(widget.controller.text)) {
      return "Password Should Contain uppercase, lowercase , digit ,  special character";
    } else {
      return null;
    }
  }
}

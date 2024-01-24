import 'package:del_clean_arc/core/app_theme.dart';
import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        icon: isUpdatePost ?const Icon(Icons.edit,color: Colors.white,) :const Icon(Icons.add,color: Colors.white,),
        label: Text(isUpdatePost ? "Update" : "Add",style: const TextStyle(color: Colors.white,),),);
  }
}
import 'dart:io';

import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/models/user_model.dart';
import 'package:citchat/shared/custom_button.dart';
import 'package:citchat/shared/custom_form.dart';
import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;
  String? _uploadedImageUrl;
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = context.read<UserBloc>();
    final nameC = TextEditingController(text: "");
    final emailC = TextEditingController(text: "");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile', style: poppinsTextStyle,),
      ),
      body: StreamBuilder<User>(
        stream: userBloc.streamUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Tidak dapat mengambil data'),
            );
          }
          User? user = snapshot.data;
          emailC.text = user!.email!;
          nameC.text = user.name!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                // padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: () {
                      uploadPic(context);
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (_imageFile != null)
                              ? FileImage(_imageFile!)
                              : (user.photo != null)
                              ? NetworkImage(user.photo!)
                              : const AssetImage('assets/images/ava.jpg') as ImageProvider<Object>,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 24,
                          height: 24,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              uploadPic(context);
                            },
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CFormField(
                    keyboardType: TextInputType.none,
                    controller: emailC,
                    title: "Email",
                  ),CFormField(
                    controller: nameC,
                    title: "Name",
                  ),
                  const SizedBox(height: 4,),
                  CFillButton(
                    title: 'Update',
                    onPressed: () {
                      context.read<UserBloc>().add(
                        UserEventUpdate(nameC.text),
                      );
                    },
                  ),

                  BlocListener<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UserStateSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message, style: poppinsTextStyle,)));
                      }
                      if (state is UserStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.err, style: poppinsTextStyle,)));
                      }
                    },
                    child: const SizedBox(),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void uploadPic(BuildContext context) async{
    final picker = ImagePicker();
    if (await Permission.camera.request().isGranted ) {
      var image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = File(image!.path);
        context.read<UserBloc>().add(
          UserEventUpdatePhoto(_imageFile!),
        );
      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "If you reject permission, you can't use this service.",
            style: poppinsTextStyle,
          ),
          duration: const Duration(milliseconds: 1000),
        ),
      );
    }
  }
}

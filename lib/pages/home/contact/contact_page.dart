import 'dart:convert';
import 'dart:math';

import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/models/user_model.dart';
import 'package:citchat/shared/custom_card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../shared/custom_form.dart';
import '../../../shared/theme.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    PeopleBloc peopleBloc = context.read<PeopleBloc>();
    final searchC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('People', style: poppinsTextStyle.copyWith(fontWeight: medium),),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: CFormField(
                controller: searchC,
                isShowTitle: false,
                isShowIcon: true,
                title: "Search people",
                icon: const Icon(Iconsax.sms_search),
              ),
            ),
          ],
        )
      ),
      body: StreamBuilder<QuerySnapshot<User>>(
        stream: peopleBloc.streamPeople(),
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
          List<User> allPeople = [];
          for (var element in snapshot.data!.docs) {
            allPeople.add(element.data());
          }
          if (allPeople.isEmpty) {
            return const Center(
              child: Text("Tidak ada data."),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _listPeople(allPeople)
              ],
            ),
          );
        }
      ),
    );
  }
  Widget _listPeople(List<User> allPeople) {
    return Expanded(
      child: GridView.builder(
        itemCount: allPeople.length,
        itemBuilder: (context, index) {
          User user = allPeople[index];
          return CardPeopleItem(name: user.name!, email: user.email!, photo: "");
        },
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
        ),
      ),
    );
  }
}

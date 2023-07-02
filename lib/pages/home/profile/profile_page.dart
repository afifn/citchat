import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/models/user_model.dart';
import 'package:citchat/routes/router.dart';
import 'package:citchat/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../shared/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    UserBloc userBloc = context.read<UserBloc>();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: poppinsTextStyle.copyWith(fontWeight: medium),
          ),
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
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              children: [
                Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (user!.photo.isNotEmpty)
                              ? NetworkImage(user.photo)
                              : const AssetImage("assets/images/ava.jpg")
                                  as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: monsterratTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                          Text(
                            user.email,
                            style: monsterratTextStyle.copyWith(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    CIconButton(
                      icon: const Icon(Iconsax.edit),
                      onPressed: () {
                        context.goNamed(
                          RouteName.editProfile,
                          pathParameters: {'id': user.uid},
                          extra: user,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'My status',
                  style: monsterratTextStyle.copyWith(
                      fontSize: 14, fontWeight: medium),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CIconTextButton(
                        value: 1,
                        title: 'Gaming',
                        icon: const Icon(Iconsax.game),
                        bgColor: colorScheme.primary,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 8),
                      CIconTextButton(
                        title: 'Away',
                        icon: const Icon(Iconsax.bag_tick),
                        bgColor: colorScheme.error,
                        value: 2,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 8),
                      CIconTextButton(
                        title: 'At Work',
                        icon: const Icon(Iconsax.monitor),
                        bgColor: colorScheme.secondary,
                        value: 3,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 8),
                      CIconTextButton(
                        title: 'Busy',
                        icon: const Icon(BoxIcons.bx_sleepy),
                        bgColor: colorScheme.tertiary,
                        value: 4,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'My Account',
                  style: monsterratTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(
                  height: 4,
                ),
                CTextButton(
                  title: 'Switch to Other Account',
                  onPressed: () {},
                ),
                CTextButton(
                  title: 'Sign Out',
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogout());
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthStateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        state.message,
                        style: poppinsTextStyle,
                      )));
                      setState(() {
                        context.goNamed(RouteName.login);
                      });
                    }
                    if (state is AuthStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        state.error,
                        style: poppinsTextStyle,
                      )));
                    }
                  },
                  child: const SizedBox(),
                ),
              ],
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/colors/generic_colors.dart';
import '../../../../configs/router/app_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../../../shared/presentation/custom_app_bar.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/presentation/providers/logged_user_provider.dart';
import '../../../user/presentation/providers/logged_user_state.dart';
import '../../../user/presentation/providers/users_provider.dart';
import '../widgets/profile_section.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final User user = ref.watch(loggedUserProvider.select((v) => v is LoggedUserLoaded ? v.user : User.empty()));

    final textTheme = Theme.of(context).textTheme;

    ref.listen<AuthState>(
      authProvider,
      (prev, next) {
        if (next is LoggedOut) {
          AppRouter.replaceAndRemoveUntil('/login');
          ref.invalidate(authProvider);
          ref.read(chatProvider.notifier).disconnect();
          ref.read(usersProvider.notifier).reset();
          ref.read(loggedUserProvider.notifier).reset();
        }
      },
    );

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 160,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withOpacity(.7),
                      width: .6,
                    ),
                  ),
                ),
                child: Image.network(
                  // TODO(BRANDOM): Temporary image
                  'https://avatars.githubusercontent.com/u/79495707?v=4',
                ),
              ),
            ),
            const SizedBox(height: 30),
            ProfileSection(
              title: 'Name',
              value: user.name,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 15),
            ProfileSection(
              title: 'Email',
              value: user.email,
              icon: Icons.email_outlined,
            ),
            const Spacer(),
            Center(
              child: FilledButton(
                onPressed: auth is! AuthLoading ? () => ref.read(authProvider.notifier).logout() : null,
                child: Text(
                  'Logout',
                  style: textTheme.labelLarge?.copyWith(
                    color: TColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

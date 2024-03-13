import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/pages/userdetails/user_details.dart';
import 'package:flutter_boilerplate/providers/users_provider.dart';
import 'package:flutter_boilerplate/widgets/circular_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/data/remote/user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late UsersProvider usersProvider;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();
    usersProvider = Provider.of<UsersProvider>(context, listen: false);
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      usersProvider.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    var asyncResponse = context.watch<UsersProvider>().asyncResponse;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Row(children: [
                Icon(Icons.group, size: 32, color: colorScheme.onBackground),
                const SizedBox(width: 16),
                Text(appLocalizations.users,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onBackground))
              ])),
          // loader
          if (asyncResponse?.loading == true) ...[
            const Expanded(child: CircularProgressBar())
          ],
          // error
          if (asyncResponse?.error != null) ...[
            Expanded(child: Center(child: Text(asyncResponse?.error ?? '')))
          ],
          // data
          if (asyncResponse?.data?.isNotEmpty == true) ...[
            Expanded(
                child: RefreshIndicator(
                    backgroundColor: colorScheme.background,
                    color: colorScheme.onBackground,
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 250));
                      usersProvider.fetchUsers(onRefresh: true);
                    },
                    child: ListView.builder(
                        itemCount: asyncResponse?.data?.length,
                        itemBuilder: (context, index) {
                          final item = asyncResponse?.data?[index];
                          return Card(
                              elevation: 0,
                              margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => {_openUserDetails(item)},
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    key: Key(item?.phone ?? ''),
                                    tileColor: colorScheme.surface,
                                    dense: true,
                                    leading: Image.network(
                                        item?.picture?.large ?? ''),
                                    title: Text(
                                        '${item?.name?.title} ${item?.name?.first} ${item?.name?.last}',
                                        style: const TextStyle(fontSize: 16)),
                                    subtitle: Text(
                                        '${item?.email}\n${item?.phone}',
                                        style: const TextStyle(fontSize: 14)),
                                  )));
                        })))
          ],
        ],
      )),
    );
  }

  void _openUserDetails(User? user) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const UserDetailsPage(),
        settings: RouteSettings(arguments: user)));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/model/data/remote/user.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: colorScheme.surface,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
              tooltip: appLocalizations.back,
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(appLocalizations.user_details,
                style: TextStyle(
                    fontSize: 20,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold))),
        body: Column(children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: colorScheme.surfaceContainer,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(user.picture?.large ?? '')),
                  const SizedBox(height: 24),
                  Text(
                      '${user.name?.title} ${user.name?.first} ${user.name?.last}',
                      style: TextStyle(
                          fontSize: 18, color: colorScheme.surfaceContainerHighest)),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                Row(children: [
                  Text(appLocalizations.more_details,
                      style: TextStyle(
                          fontSize: 24,
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold))
                ]),
                const SizedBox(height: 32),
                Row(children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(width: 16),
                  Text(user.email ?? '',
                      style: TextStyle(
                          fontSize: 16, color: colorScheme.onSurface))
                ]),
                const SizedBox(height: 24),
                Row(children: [
                  const Icon(Icons.person_outline),
                  const SizedBox(width: 16),
                  Text(user.gender ?? '',
                      style: TextStyle(
                          fontSize: 16, color: colorScheme.onSurface))
                ]),
                const SizedBox(height: 24),
                Row(children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 16),
                  Text(user.dob?.date ?? '',
                      style: TextStyle(
                          fontSize: 16, color: colorScheme.onSurface))
                ]),
                const SizedBox(height: 24),
                Row(children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 16),
                  Text(user.location?.country ?? '',
                      style: TextStyle(
                          fontSize: 16, color: colorScheme.onSurface))
                ]),
                const SizedBox(height: 24),
                Row(children: [
                  const Icon(Icons.phone_outlined),
                  const SizedBox(width: 16),
                  Text(user.phone ?? '',
                      style: TextStyle(
                          fontSize: 16, color: colorScheme.onSurface))
                ])
              ]))
        ]));
  }
}

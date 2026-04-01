import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/blocs/profile/profile_bloc.dart';
import 'package:form_app/blocs/profile/profile_event.dart';
import 'package:form_app/blocs/profile/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // fetch on open
    context.read<ProfileBloc>().add(FetchProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.numbers),
                        title: const Text('ID'),
                        subtitle: Text(state.profile.id.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('User ID'),
                        subtitle: Text(state.profile.userId.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.title),
                        title: const Text('Title'),
                        subtitle: Text(state.profile.title),
                      ),
                      ListTile(
                        leading: const Icon(Icons.article),
                        title: const Text('Body'),
                        subtitle: Text(state.profile.body),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          // initial state
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

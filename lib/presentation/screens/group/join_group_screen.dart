// File: lib/presentation/screens/group/join_group_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/group/join_group_cubit.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/app_button.dart';
import '../../../config/routes.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({Key? key}) : super(key: key);

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final _joinCodeController = TextEditingController();
  String? _joinCodeError;

  @override
  void initState() {
    super.initState();
    context.read<JoinGroupCubit>().reset();
  }

  @override
  void dispose() {
    _joinCodeController.dispose();
    super.dispose();
  }

  void _validateJoinCode(String value) {
    setState(() {
      if (value.isEmpty) {
        _joinCodeError = 'Join code is required';
      } else if (value.length < 6) {
        _joinCodeError = 'Enter a valid join code';
      } else {
        _joinCodeError = null;
      }
    });
  }

  void _joinGroup() {
    _validateJoinCode(_joinCodeController.text);

    if (_joinCodeError == null) {
      context.read<JoinGroupCubit>().joinGroup(_joinCodeController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join a Family Group'),
      ),
      body: BlocConsumer<JoinGroupCubit, JoinGroupState>(
        listener: (context, state) {
          if (state is JoinGroupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Successfully joined ${state.group.name}')),
            );

            // Navigate to the joined group
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.groupDetails,
                  (route) => route.settings.name == AppRouter.home,
              arguments: {'groupId': state.group.id},
            );
          } else if (state is JoinGroupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join an existing family group',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the join code shared by a family group admin to join their group.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                AppTextField(
                  label: 'Join Code',
                  hint: 'Enter the 6-digit join code',
                  controller: _joinCodeController,
                  errorText: _joinCodeError,
                  onChanged: _validateJoinCode,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: 'Join Group',
                  onPressed: _joinGroup,
                  isLoading: state is JoinGroupLoading,
                  isDisabled: _joinCodeError != null || _joinCodeController.text.isEmpty,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
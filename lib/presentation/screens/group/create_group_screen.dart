// File: lib/presentation/screens/group/create_group_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/group/create_group_cubit.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/app_button.dart';
import '../../../config/routes.dart';
import '../../widgets/group/join_code_widget.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _nameError;

  @override
  void initState() {
    super.initState();
    context.read<CreateGroupCubit>().reset();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateName(String value) {
    setState(() {
      if (value.isEmpty) {
        _nameError = 'Group name is required';
      } else if (value.length < 3) {
        _nameError = 'Group name must be at least 3 characters';
      } else {
        _nameError = null;
      }
    });
  }

  void _createGroup() {
    _validateName(_nameController.text);

    if (_nameError == null) {
      context.read<CreateGroupCubit>().createGroup(
        _nameController.text,
        _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Family Group'),
      ),
      body: BlocConsumer<CreateGroupCubit, CreateGroupState>(
        listener: (context, state) {
          if (state is CreateGroupSuccess) {
            // Show success dialog with join code
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text('Group Created!'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Your group has been created successfully. Share this code with your family members so they can join:',
                    ),
                    const SizedBox(height: 16),
                    JoinCodeWidget(
                      joinCode: state.group.joinCode ?? '',
                      onShare: () {/* Share functionality */},
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Navigate to the newly created group
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouter.groupDetails,
                            (route) => route.settings.name == AppRouter.home,
                        arguments: {'groupId': state.group.id},
                      );
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            );
          } else if (state is CreateGroupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create a private group for your family',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your family members will be able to join using a special code that will be generated.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    label: 'Group Name',
                    hint: 'Enter a name for your family group',
                    controller: _nameController,
                    errorText: _nameError,
                    onChanged: _validateName,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Description (Optional)',
                    hint: 'Describe your family group',
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    text: 'Create Group',
                    onPressed: _createGroup,
                    isLoading: state is CreateGroupLoading,
                    isDisabled: _nameError != null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
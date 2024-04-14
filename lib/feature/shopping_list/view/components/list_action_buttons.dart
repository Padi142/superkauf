import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/generic/shopping_list/bloc/shopping_list_data_bloc.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/library/app.dart';

class ListActionButtons extends StatelessWidget {
  final ShoppingListModel list;
  final bool canEdit;

  const ListActionButtons({
    super.key,
    required this.list,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
      ),
      // Icon for three dots
      onSelected: (String value) async {
        switch (value) {
          case 'delete':
            {
              _showConfirmDeletion(context, () {
                BlocProvider.of<ShoppingListDataBloc>(context).add(DeleteList(listId: list.id));
              });

              break;
            }
          case 'invite':
            {
              _showInviteCode(context, list.code, () {});
              break;
            }
          case 'leave':
            {
              _showConfirmLeaving(context, () {
                BlocProvider.of<ShoppingListDataBloc>(context).add(LeaveList(listId: list.id));
              });
              break;
            }
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        final List<PopupMenuItem<String>> list = [];
        if (canEdit) {
          list.add(
            const PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Delete list'),
                ],
              ),
            ),
          );
        }

        list.add(
          const PopupMenuItem<String>(
            value: 'invite',
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Invite user'),
              ],
            ),
          ),
        );
        list.add(
          const PopupMenuItem<String>(
            value: 'leave',
            child: Row(
              children: [
                Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Leave list'),
              ],
            ),
          ),
        );

        return list;
      },
    );
  }

  void _showConfirmDeletion(BuildContext context, Function() onDone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            title: const Text('Do you really want to delete this list?'),
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  onDone();
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmLeaving(BuildContext context, Function() onDone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            title: const Text('Do you really want to leave this list?'),
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  onDone();
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInviteCode(BuildContext context, String code, Function() onDone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            title: const Text('Share this code with the person you want to invite'),
            backgroundColor: Theme.of(context).colorScheme.background,
            titleTextStyle: App.appTheme.textTheme.titleSmall,
            content: SelectableText(code, style: App.appTheme.textTheme.titleLarge),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('close'),
              ),
            ],
          ),
        );
      },
    );
  }
}

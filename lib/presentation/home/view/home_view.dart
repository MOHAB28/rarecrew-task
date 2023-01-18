// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_router.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../viewmodel/home_viewmodel.dart';
import '../model/model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRouterNames.profileRouteName),
          icon: const Icon(Icons.person),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRouterNames.addRouteName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final homeNotifier = ref.watch(homeViewmodel);
          return ListView.separated(
            padding: const EdgeInsets.all(20.0),
            physics: const BouncingScrollPhysics(),
            itemCount: homeNotifier.items.length,
            itemBuilder: (ctx, i) =>
                HomeItemBuilder(item: homeNotifier.items[i]),
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
          );
        },
      ),
    );
  }
}

class HomeItemBuilder extends ConsumerWidget {
  const HomeItemBuilder({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeNotifier = ref.watch(homeViewmodel);
    return Card(
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.description),
        trailing: Text('\$${item.price}'),
        onLongPress: () => showDialog(
          context: context,
          builder: (ctx) => CustomAlertDialog(
            ctx: ctx,
            title: 'Are you sure?',
            message: 'Do you want to delete this item?',
            actions: [
              TextButton(
                onPressed: () {
                  homeNotifier.deleteItem(item.id!);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('No'),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.pushNamed(
          context,
          AppRouterNames.addRouteName,
          arguments: item.id,
        ),
      ),
    );
  }
}

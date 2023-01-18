// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_viewmodel.dart';
import 'model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
        actions: [
          IconButton(
            onPressed: () {},
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

class HomeItemBuilder extends StatelessWidget {
  const HomeItemBuilder({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.description),
        trailing: Text('\$${item.price}'),
      ),
    );
  }
}

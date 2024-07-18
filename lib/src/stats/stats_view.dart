import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/stats/search_provider.dart';

class StatsView extends StatelessWidget {
  const StatsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            TextField(
              onChanged: searchProvider.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchProvider.searchResults.length,
                itemBuilder: (context, index) {
                  Thing thing = searchProvider.searchResults[index];

                  return ListTile(
                    title: Text(thing.name),
                    leading: Text(thing.votes.toString()),
                    key: Key(index.toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

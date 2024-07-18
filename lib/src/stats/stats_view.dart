import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/stats/search_provider.dart';

class StatsView extends StatefulWidget {
  const StatsView({
    super.key,
  });

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  final TextEditingController searchController = TextEditingController();

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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: searchProvider.search,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(Icons.search),
                      ),
                      filled: true,
                      border: const OutlineInputBorder(),
                      suffixIcon: searchController.text == ''
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  searchProvider.search('');
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: IconButton(
                    onPressed: () {
                      searchProvider.refresh();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchProvider.searchResults.length,
                itemBuilder: (context, index) {
                  Thing thing = searchProvider.searchResults[index];

                  return ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      thing.name,
                    ),
                    leading: Text(
                      (index + 1).toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    trailing: Text(
                      thing.votes.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/stats/search_provider.dart';
import 'package:rank_everything/src/stats/submit_form.dart';

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

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 14, 6, 6),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Showing the 10 ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                DropdownButton(
                  value: searchProvider.ascending,
                  style: Theme.of(context).textTheme.titleMedium,
                  selectedItemBuilder: (context) => [
                    // Yes it has to be like this to avoid the tiny gap between the
                    // arrow and the text
                    // The width of the dropdown is the same as the smallest item, and
                    // we have two because it needs to be the same length as values
                    Text(searchProvider.ascending ? "worst" : "best"),
                    Text(searchProvider.ascending ? "worst" : "best")
                  ],
                  isDense: true,
                  items: const [
                    DropdownMenuItem(
                      value: false,
                      child: Text("best"),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text("worst"),
                    )
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    searchProvider.setAscending(value);
                    searchProvider.search(
                      searchController.text,
                      override: true,
                    );
                  },
                ),
                // Split the last two for some jank text wrapping
                Text(
                  " things ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "ever!",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Card(
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
                      thing.getPercentage().toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    key: Key(index.toString()),
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                Expanded(child: Divider()),
                Text("Missing something?"),
                Expanded(child: Divider()),
              ],
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const SubmitForm();
                },
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Submit your own thing!"),
          )
        ],
      ),
    );
  }
}

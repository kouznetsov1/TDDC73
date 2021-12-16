import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3/repo.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _authToken = "";

  @override
  Widget build(BuildContext context) {
    final HttpLink _httpLink = HttpLink('https://api.github.com/graphql');

    final AuthLink _authLink =
        AuthLink(getToken: () async => 'Bearer $_authToken');

    final Link _link = _authLink.concat(_httpLink);

    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: _link,
      cache: GraphQLCache(store: InMemoryStore()),
    ));

    return GraphQLProvider(
        client: _client,
        child: MaterialApp(
          title: 'Lab 3',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  final String title = "Trending github repos";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currLang = "Python";

  final List<String> _languages = [
    "JavaScript",
    "TypeScript",
    "Go",
    "Rust",
    "Swift",
    "Web",
    "PHP",
    "CSS",
    "C",
    "C#",
    "C++",
    "Python",
    "Ruby",
    "Java",
  ];

  // change this one using variables etc, just as they do in the docs
  // ignore: prefer_final_fields
  String readRepositories = """
  query(\$querySearch: String!) {
    search(query: \$querySearch, type: REPOSITORY, first: 10){
      nodes {
        ... on Repository {
          name
          description
          nameWithOwner
          stargazerCount
          forkCount
          licenseInfo {
            name
          }
          object(expression: "master"){
            ... on Commit {
              history {
                totalCount
              }
            }
          }
          refs(refPrefix: "refs/heads/"){
            totalCount
          }
        }
      }
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Container(
              height: 550,
              child: Query(
                options: QueryOptions(
                  document: gql(readRepositories),
                  variables: {
                    'querySearch':
                        'sort:stars-desc language:$_currLang stars:>1000'
                  },
                  pollInterval: const Duration(seconds: 10),
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return const Center(
                      child: Text('Loading...', style: TextStyle(fontSize: 40)),
                    );
                  }

                  // it can be either Map or List
                  List repositories = result.data!['search']['nodes'];

                  return ListView.builder(
                      itemCount: repositories.length,
                      itemBuilder: (context, index) {
                        final repository = repositories[index];

                        // all variables that is being passed to repo widget
                        String name = repository['name'];
                        String description = repository['description'];
                        String nameWithOwner = repository['nameWithOwner'];
                        String stargazerCount =
                            repository['stargazerCount'].toString();
                        String forkCount = repository['forkCount'].toString();
                        String commits =
                            repository['refs']['totalCount'].toString();
                        String? licenseName;
                        String? branches;

                        if (repository['licenseInfo'] != null) {
                          licenseName = repository['licenseInfo']['name'];
                        }
                        licenseName ??= "Unknown";

                        if (repository['object'] != null) {
                          branches = repository['object']['history']
                                  ['totalCount']
                              .toString();
                        }
                        branches ??= "Unknown";

                        return Repo(
                          name: name,
                          description: description,
                          nameWithOwner: nameWithOwner,
                          stargazerCount: stargazerCount,
                          forkCount: forkCount,
                          licenseName: licenseName,
                          commits: commits,
                          branches: branches,
                        );
                      });
                },
              ),
            ),
            Container(
              //height: 30,
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.amber,
              child: DropdownButton<String>(
                value: _currLang,
                underline: Container(
                  color: Colors.transparent,
                ),
                items: _languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _currLang = newValue!;
                  });
                },
              ),
            )
          ],
        ));
  }
}

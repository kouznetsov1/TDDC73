import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  runApp(const MyApp());
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
    final HttpLink _httpLink = HttpLink('https://api.github.com/graphql',
        defaultHeaders: {"authorization": "bearer $_authToken"});

    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: _httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));

    return GraphQLProvider(
        client: _client,
        child: MaterialApp(
          title: 'Lab 3',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Lab 3'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currLang = "Python";

  final List<String> _languages = [
    "Top Overall",
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
  String _readRepositories = """
  query ReadRepositories (\$_queryInput: String!){
    search(query: \$_queryInput, type: REPOSITORY, first: 10){
      nodes {
          ... on Repository {
            id
            name
            url
             owner {
              url
            }
            stargazers {
              totalCount
            }
            forks {
              totalCount
            }
           
            licenseInfo {
              name
            }
            description
            refs(refPrefix: "refs/heads/") {
              totalCount
            }
            object(expression: "master") {
              ... on Commit {
                history {
                  totalCount
                }
              }
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
      body: Container(
        child: Query(
          options: QueryOptions(
            document: gql(_readRepositories),
            variables: {
              '_queryInput': 'sort:stars-desc language: $_currLang stars: >1000',
            },
            pollInterval: const Duration(seconds: 10),
          ),

          builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Text('Loading');
            }

            // it can be either Map or List
            List repositories = result.data!['search']['nodes'];

            return ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  final repository = repositories[index];

                  return Text(repository['name']);
                });
          },
        ),
      ),
    );
  }
}

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
  // Personal token, good for 30 days -> 12/1-2022
  final String _authToken = "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";

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

  // ignore: prefer_final_fields
  String _readRepositories = """
  search(query: "sort:stars-desc language: \$_currLang stars:>1000", type: REPOSITORY, first:10){
    repositoryCount
    edges {
      node {
        ... on Repository {
          name
          description
          stargazers {
            totalCount
          }
          forks {
            totalCount
          }
          licenseInfo {
            name
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
            pollInterval: 10,
          ),
          builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException){
              return Text(result.exception.toString());
            }
            if (result.isLoading){
              return Text("Loading");
            }
            List _repositories = result.data['viewer']['repositories']['nodes'];
            return Text(_repositories[0]['name']);
          },

        ),
      ),
    );
  }
}

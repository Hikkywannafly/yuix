import 'package:graphql_flutter/graphql_flutter.dart';

// final readRespositoriesResult = useQuery(
//   QueryOptions(
//     document:
//         gql(readRepositories), // this is the query string you just created
//     variables: {
//       'nRepositories': 50,
//     },
//     pollInterval: const Duration(seconds: 10),
//   ),
// );
// final result = readRespositoriesResult.result;

// if (result.hasException) {
//     return Text(result.exception.toString());
// }

// if (result.isLoading) {
//   return const Text('Loading');
// }

// List? repositories = result.data?['viewer']?['repositories']?['nodes'];

// if (repositories == null) {
//   return const Text('No repositories');
// }


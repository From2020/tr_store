import 'package:provider/provider.dart';

import '../services/providers/cart_count.dart';
import '../services/providers/item_id.dart';

var providers = [
  ChangeNotifierProvider<CountNotifier>(create: ((context) => CountNotifier())),
  ChangeNotifierProvider<ItemIdNotifier>(
      create: ((context) => ItemIdNotifier())),
];

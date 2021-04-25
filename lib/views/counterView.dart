import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:noor/provider/count.dart';


 count(context)  {


    
    return Text(

        /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
        '${context.watch<Counter>().getCounter}',
        key: const Key('counterState'),
        style: Theme.of(context).textTheme.headline4);
  
}

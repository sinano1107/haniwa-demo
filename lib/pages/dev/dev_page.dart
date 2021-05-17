import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dev_view_model.dart';
import 'login_button.dart';

class DevPage extends StatelessWidget {
  static const id = 'dev';

  final String title;
  DevPage({@required this.title});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DevViewModel()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    Provider.of<DevViewModel>(context).counter.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  LoginButton(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: Provider.of<DevViewModel>(context, listen: false)
                  .incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

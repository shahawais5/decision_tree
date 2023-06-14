import 'package:flutter/material.dart';

class TreeNode {
  String label;
  Map<String, dynamic> children;

  TreeNode({required this.label, required this.children});
}

class DecisionTree {
  TreeNode? root;

  DecisionTree() {
    root = buildDecisionTree();
  }

  TreeNode buildDecisionTree() {
    TreeNode node1 = TreeNode(
      label: 'Outlook',
      children: {
        'Sunny': TreeNode(
          label: 'Play',
          children: {},
        ),
        'Overcast': TreeNode(
          label: 'Play',
          children: {},
        ),
        'Rainy': TreeNode(
          label: 'Humidity',
          children: {
            'High': TreeNode(
              label: 'No Play',
              children: {},
            ),
            'Normal': TreeNode(
              label: 'Play',
              children: {},
            ),
          },
        ),
      },
    );

    return node1;
  }

  ///we added a List<Map<String, String>> inputList that contains multiple input examples
  ///The predict method is applied to each input in the list using the map function
  ///to generate a list of predictions.
  ///In the UI, we iterate over the inputList and display each input
  ///along with its corresponding prediction.

  String predict(Map<String, String> input) {
    TreeNode? currentNode = root;
    while (currentNode != null) {
      String attribute = currentNode.label;
      if (input.containsKey(attribute)) {
        String attributeValue = input[attribute]!;
        if (currentNode.children.containsKey(attributeValue)) {
          currentNode = currentNode.children[attributeValue] as TreeNode?;
        } else {
          return 'Unknown';
        }
      } else {
        return 'Unknown';
      }
    }
    return 'Unknown';
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DecisionTree decisionTree = DecisionTree();
  final List<Map<String, String>> inputList = [
    {'Outlook': 'Sunny', 'Humidity': 'High'},
    {'Outlook': 'Overcast', 'Humidity': 'Normal'},
    {'Outlook': 'Rainy', 'Humidity': 'High'},
    {'Outlook': 'Sunny', 'Humidity': 'Normal'},
  ];

  @override
  Widget build(BuildContext context) {
    List<String> predictions = inputList.map((input) {
      return decisionTree.predict(input);
    }).toList();

    return MaterialApp(
      title: 'Decision Tree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Decision Tree'),
        ),
        ///The UI will show the results of applying the decision tree to each input example,
        /// displaying the input and its corresponding prediction in a formatted manner.
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Decision Tree Results',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              for (int i = 0; i < inputList.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Input: ${inputList[i].toString()}\nPrediction: ${predictions[i]}',
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

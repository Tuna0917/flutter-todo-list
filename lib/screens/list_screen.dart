import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/providers/todo_default.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListScreenState();
  }
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  TodoDefault todoDefault = TodoDefault();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      todos = todoDefault.getTodos();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록 앱'),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(5),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book),
                  Text('뉴스'),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String title = '';
                String description = '';
                return AlertDialog(
                  title: const Text('ToDo 추가하기'),
                  content: SizedBox(
                    height: 200,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              title = value;
                            },
                            decoration: const InputDecoration(labelText: '제목'),
                          ),
                          TextField(
                            onChanged: (value) {
                              description = value;
                            },
                            decoration: const InputDecoration(labelText: '설명'),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            if (kDebugMode) debugPrint("[UI] ADD");
                            todoDefault.addTodo(
                              Todo(title: title, description: description),
                            );
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('추가'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                );
              });
        },
        child: const Text('+', style: TextStyle(fontSize: 25)),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text('ToDo'),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Text('제목 : ${todos[index].title}'),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Text('설명 : ${todos[index].description}'),
                              ),
                            ],
                          );
                        });
                  },
                  trailing: SizedBox(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    int? id = todos[index].id;
                                    String title = todos[index].title;
                                    String description =
                                        todos[index].description;
                                    return AlertDialog(
                                      title: const Text('할 일 수정하기'),
                                      content: SizedBox(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            TextField(
                                              onChanged: (value) {
                                                title = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText: todos[index].title,
                                              ),
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                description = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    todos[index].description,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            Todo changedTodo = Todo(
                                              id: id,
                                              title: title,
                                              description: description,
                                            );
                                            setState(() {
                                              todoDefault
                                                  .updateTodo(changedTodo);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('수정'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            '취소',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: todos.length,
            ),
    );
  }
}

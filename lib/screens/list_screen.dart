import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/providers/todo_sqlite.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListScreenState();
  }
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  TodoSqlite todoSqlite = TodoSqlite();
  bool isLoading = true;

  Future initDb() async {
    await todoSqlite.initDb().then((_) async {
      todos = await todoSqlite.getTodos();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      initDb().then((_) {
        setState(() {
          isLoading = false;
        });
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
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Todo newTodo =
                            Todo(title: title, description: description);
                        await todoSqlite.addTodo(newTodo);
                        List<Todo> newTodos = await todoSqlite.getTodos();
                        setState(() {
                          todos = newTodos;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '추가',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
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
                                            await todoSqlite
                                                .updateTodo(changedTodo);
                                            List<Todo> newTodos =
                                                await todoSqlite.getTodos();
                                            setState(() {
                                              todos = newTodos;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            '수정',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
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
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('ToDo 삭제하기'),
                                      content: Container(
                                        child: const Text('삭제하시겠습니까?'),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await todoSqlite.deleteTodo(
                                                todos[index].id ?? 0);
                                            List<Todo> newTodos =
                                                await todoSqlite.getTodos();
                                            setState(() {
                                              todos = newTodos;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            '삭제',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('취소'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
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

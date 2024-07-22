import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubmitForm extends StatefulWidget {
  const SubmitForm({
    super.key,
  });

  @override
  State<SubmitForm> createState() => _SubmitForm();
}

class _SubmitForm extends State<SubmitForm> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();

  String nameError = "", imageError = "", descriptionError = "";

  bool adult = false, loading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> submit() async {
      setState(() {
        loading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      http.Response response = await http.post(
        Uri.parse('https://rank.woukie.net/submit_thing'),
        body: jsonEncode({
          "name": nameController.text,
          "description": descriptionController.text,
          "imageUrl": imageController.text,
          "adult": adult
        }),
      );

      setState(() {
        loading = false;
      });

      Map<String, dynamic> body = jsonDecode(response.body);

      if (body['status'] == 'success') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Created thing!")));
          Navigator.of(context).pop();
        }

        return;
      }

      String? param = body['param'];
      String message = body['message'] ?? "";
      if (param != null) {
        setState(() {
          switch (param) {
            case 'name':
              nameError = message;
              break;
            case 'imageUrl':
              imageError = message;
              break;
            case 'description':
              descriptionError = message;
              break;
            default:
          }
        });
      }
    }

    return Center(
      child: Card(
        margin: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                enabled: !loading,
                onChanged: (value) => setState(() {
                  nameError = "";
                }),
                decoration: InputDecoration(
                  error: nameError.isEmpty ? null : Text(nameError),
                  label: const Text("Name"),
                  border: const OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(3)),
              TextField(
                controller: descriptionController,
                enabled: !loading,
                onChanged: (value) => setState(() {
                  descriptionError = "";
                }),
                decoration: InputDecoration(
                  error:
                      descriptionError.isEmpty ? null : Text(descriptionError),
                  label: const Text("Description"),
                  border: const OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(3)),
              Row(
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageController.text,
                        fit: BoxFit.cover,
                        width: 56,
                        height: 56,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.image_not_supported_outlined,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 56,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(3)),
                  Expanded(
                    child: TextField(
                      controller: imageController,
                      enabled: !loading,
                      onChanged: (value) => setState(() {
                        imageError = "";
                      }),
                      decoration: InputDecoration(
                        error: imageError.isEmpty ? null : Text(imageError),
                        label: const Text("Image URL"),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "The image URL must point directly to a valid image hosted on the web",
              ),
              Row(
                children: [
                  Switch(
                    value: adult,
                    onChanged: loading
                        ? null
                        : (value) {
                            setState(() {
                              adult = value;
                            });
                          },
                  ),
                  const Padding(padding: EdgeInsets.all(3)),
                  const Text("Adult"),
                ],
              ),
              const Text(
                "Enable 'Adult' if the image contains adult material not suitable for a young audience",
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.tonal(
                    onPressed: loading
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child: const Text("Cancel"),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 6)),
                  FilledButton(
                    onPressed: loading
                        ? null
                        : () {
                            submit();
                          },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

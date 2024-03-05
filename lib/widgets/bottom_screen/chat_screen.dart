import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Contact> contacts = [
    Contact(name: "John", phoneNumber: "123-456-7890"),
    Contact(name: "Alice", phoneNumber: "987-654-3210"),
    Contact(name: "Bob", phoneNumber: "456-789-0123"),
    Contact(name: "James", phoneNumber: "456-789-0123"),
    Contact(name: "Benz", phoneNumber: "456-789-0123"),
    Contact(name: "Oil", phoneNumber: "123-456-7890"),
    Contact(name: "Den", phoneNumber: "123-456-7890"),

    // Add more contacts
  ];
  String selectedContact = '';

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Handle back arrow press
              },
            ),
            Spacer(),
            Text(
              "CHAT",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.language, color: Colors.white),
              onPressed: () {
                // Handle language icon press
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchContact(contacts),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "List Contact",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: selectedContact == contacts[index].name
                        ? Colors.redAccent
                        : Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          contacts[index].name[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            contacts[index].name,
                            style: TextStyle(
                              fontWeight:
                                  selectedContact == contacts[index].name
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: selectedContact == contacts[index].name
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editContact(contacts[index]);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteContact(contacts[index]);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MessengerScreen(contacts[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new contact
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
    );
  }

  void _editContact(Contact contact) {}

  void _deleteContact(Contact contact) {}
}

class SearchContact extends SearchDelegate<Contact> {
  final List<Contact> contacts;

  SearchContact(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.grey),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? contacts
        : contacts
            .where((contact) =>
                contact.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(suggestionList[index].name),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}

class Contact {
  String name;
  String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

class EditContactScreen extends StatefulWidget {
  final String contactName;
  final List<Contact> contacts;

  EditContactScreen(this.contactName, this.contacts);

  @override
  _EditContactScreenState createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    // Find the contact details based on the name
    Contact? contact = widget.contacts.firstWhere(
      (contact) => contact.name == widget.contactName,
    );
    if (contact != null) {
      nameController = TextEditingController(text: contact.name);
      phoneController = TextEditingController(text: contact.phoneNumber);
    } else {
      nameController = TextEditingController();
      phoneController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  // Find and update the contact details
                  Contact? contact = widget.contacts.firstWhere(
                    (contact) => contact.name == widget.contactName,
                  );
                  if (contact != null) {
                    contact.name = nameController.text;
                    contact.phoneNumber = phoneController.text;
                    setState(() {});
                  }
                }
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

class MessengerScreen extends StatefulWidget {
  final Contact contact;

  MessengerScreen(this.contact);

  @override
  _MessengerScreenState createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  TextEditingController messageController = TextEditingController();
  List<String> messages = [
    "Hello, how are you?",
    "Hi there!",
    "Nice to meet you!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(messages[index]);
                },
              ),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Your message...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
              _sendAutoReply();
            },
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = messageController.text;
    if (message.isNotEmpty) {
      setState(() {
        messages = [...messages, message];
      });
      messageController.clear();
    }
  }

  void _sendAutoReply() {
    // สร้างข้อความอัตโนมัติ และเพิ่มเข้าในรายชื่อข้อความ
    String autoReply = "Thank you for your message! I'll get back to you soon.";
    setState(() {
      messages = [...messages, autoReply];
    });
  }
}

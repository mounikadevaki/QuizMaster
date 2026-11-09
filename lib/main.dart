import 'dart:async';
import 'package:flutter/material.dart';
 
// TEMPORARY USER DATA
Map<String, Map<String, String>> users = {
  'demo@gmail.com': {
    'name': 'Demo User',
    'password': '123456',
  }
};
 
List<Map<String, dynamic>> leaderboard = [];
 
// QUESTION MODEL
class Question {
  final String question;
  final List<String> options;
  final int answer;
 
  Question(this.question, this.options, this.answer);
}
 
// QUIZ DATA
final Map<String, List<Question>> quizData = {
  'Flutter': [
    Question('What language is used in Flutter?',
        ['Java', 'Dart', 'Python', 'C'], 1),
    Question('Who developed Flutter?',
        ['Google', 'Microsoft', 'Apple', 'Amazon'], 0),
    Question('What is a widget?',
        ['UI building block', 'Database', 'Language', 'Server'], 0),
  ],
  'Python': [
    Question('Who developed Python?',
        ['James Gosling', 'Guido van Rossum', 'Dennis Ritchie', 'Bjarne'], 1),
    Question('Which symbol is used for comments?',
        ['//', '#', '/*', r'$'], 1),
    Question('Which data type stores True or False?',
        ['String', 'Integer', 'Boolean', 'Float'], 2),
  ],
  'Java': [
    Question('Java is a ____ language.',
        ['Markup', 'Programming', 'Database', 'Styling'], 1),
    Question('Which keyword creates an object?',
        ['class', 'new', 'static', 'void'], 1),
    Question('Which method is the entry point?',
        ['start()', 'main()', 'run()', 'open()'], 1),
  ],
  'Computer Science': [
    Question('What does CPU stand for?',
        ['Central Processing Unit', 'Computer Personal Unit',
         'Central Program Utility', 'Control Processing User'], 0),
    Question('Which is an input device?',
        ['Monitor', 'Printer', 'Keyboard', 'Speaker'], 2),
    Question('What is the full form of RAM?',
        ['Read Access Memory', 'Random Access Memory',
         'Run Access Memory', 'Real Application Memory'], 1),
  ],
  'General Knowledge': [
    Question('What is the capital of India?',
        ['Mumbai', 'Delhi', 'Hyderabad', 'Chennai'], 1),
    Question('Which is the largest planet?',
        ['Earth', 'Mars', 'Jupiter', 'Venus'], 2),
    Question('How many days are there in a week?',
        ['5', '6', '7', '8'], 2),
  ],
};
 
// MAIN FUNCTION
void main() {
  runApp(const QuizMasterApp());
}
 
void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
 
// MAIN APP
class QuizMasterApp extends StatelessWidget {
  const QuizMasterApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizMaster',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF6F4FC),
      ),
      home: const LoginScreen(),
    );
  }
}
 
// LOGIN SCREEN
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 
  void login() {
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text;
 
    if (users.containsKey(email) &&
        users[email]!['password'] == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            userName: users[email]!['name']!,
            email: email,
          ),
        ),
      );
    } else {
      showMessage(context, 'Invalid email or password');
    }
  }
 
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.quiz,
                    size: 85, color: Colors.deepPurple),
                const SizedBox(height: 15),
                const Text(
                  'QuizMaster',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const Text('Learn • Practice • Improve'),
                const SizedBox(height: 35),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text('LOGIN'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text("Don't have an account? Sign Up"),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Demo Login: demo@gmail.com / 123456',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 
// SIGNUP SCREEN
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
 
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
 
class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
 
  void signup() {
    String name = nameController.text.trim();
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text;
 
    if (name.isEmpty || email.isEmpty ||
        password.isEmpty || confirmController.text.isEmpty) {
      showMessage(context, 'Please fill all fields');
      return;
    }
 
    if (!email.contains('@') || !email.contains('.')) {
      showMessage(context, 'Enter a valid email');
      return;
    }
 
    if (password.length < 6) {
      showMessage(context, 'Password must contain 6 characters');
      return;
    }
 
    if (password != confirmController.text) {
      showMessage(context, 'Passwords do not match');
      return;
    }
 
    if (users.containsKey(email)) {
      showMessage(context, 'Account already exists');
      return;
    }
 
    users[email] = {
      'name': name,
      'password': password,
    };
 
    showMessage(context, 'Account created successfully');
    Navigator.pop(context);
  }
 
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                const Icon(Icons.person_add,
                    size: 70, color: Colors.deepPurple),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: confirmController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signup,
                    child: const Text('CREATE ACCOUNT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 
// FORGOT PASSWORD SCREEN
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
 
  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}
 
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 
  void resetPassword() {
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text;
 
    if (!users.containsKey(email)) {
      showMessage(context, 'Email not found');
      return;
    }
 
    if (password.length < 6) {
      showMessage(context, 'Enter a password with 6 characters');
      return;
    }
 
    users[email]!['password'] = password;
    showMessage(context, 'Password changed successfully');
    Navigator.pop(context);
  }
 
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Icon(Icons.lock_reset,
                size: 75, color: Colors.deepPurple),
            const SizedBox(height: 25),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Registered Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: resetPassword,
                child: const Text('RESET PASSWORD'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
// HOME SCREEN
class HomeScreen extends StatelessWidget {
  final String userName;
  final String email;
 
  const HomeScreen({
    super.key,
    required this.userName,
    required this.email,
  });
 
  final List<IconData> icons = const [
    Icons.phone_android,
    Icons.code,
    Icons.coffee,
    Icons.computer,
    Icons.public,
  ];
 
  @override
  Widget build(BuildContext context) {
    List<String> categories = quizData.keys.toList();
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizMaster'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LeaderboardScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, $userName!',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Choose a category and test your knowledge.'),
            const SizedBox(height: 25),
            const Text(
              'Quiz Categories',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    title: categories[index],
                    icon: icons[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(
                            category: categories[index],
                            userName: userName,
                            email: email,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
// CATEGORY CARD
class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
 
  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF7E57C2), Color(0xFF512DA8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Start Quiz',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
// QUIZ SCREEN
class QuizScreen extends StatefulWidget {
  final String category;
  final String userName;
  final String email;
 
  const QuizScreen({
    super.key,
    required this.category,
    required this.userName,
    required this.email,
  });
 
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}
 
class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  int timeLeft = 20;
  int selectedAnswer = -1;
  bool advancing = false;
  Timer? timer;
 
  late List<Question> questions;
 
  @override
  void initState() {
    super.initState();
    questions = quizData[widget.category]!;
    startTimer();
  }
 
  void startTimer() {
    timer?.cancel();
    timeLeft = 20;
 
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
 
      if (timeLeft > 1) {
        setState(() {
          timeLeft--;
        });
      } else {
        t.cancel();
        nextQuestion();
      }
    });
  }
 
  void nextQuestion() {
    if (advancing || !mounted) return;
 
    advancing = true;
    timer?.cancel();
 
    if (selectedAnswer == questions[currentQuestion].answer) {
      score++;
    }
 
    if (currentQuestion == questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            userName: widget.userName,
            email: widget.email,
            category: widget.category,
            score: score,
            total: questions.length,
          ),
        ),
      );
    } else {
      setState(() {
        currentQuestion++;
        selectedAnswer = -1;
        timeLeft = 20;
      });
 
      advancing = false;
      startTimer();
    }
  }
 
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    Question q = questions[currentQuestion];
 
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestion + 1} of ${questions.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              minHeight: 8,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.timer, color: Colors.deepPurple),
                const SizedBox(width: 6),
                Text(
                  '$timeLeft seconds',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                q.question,
                key: ValueKey(currentQuestion),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            ...List.generate(q.options.length, (index) {
              bool selected = selectedAnswer == index;
 
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  color: selected
                      ? Colors.deepPurple.shade100
                      : Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        String.fromCharCode(65 + index),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(q.options[index]),
                    trailing: selected
                        ? const Icon(Icons.check_circle,
                            color: Colors.deepPurple)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedAnswer = index;
                      });
                    },
                  ),
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                currentQuestion == questions.length - 1
                    ? 'SUBMIT'
                    : 'NEXT QUESTION',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
// RESULT SCREEN
class ResultScreen extends StatelessWidget {
  final String userName;
  final String email;
  final String category;
  final int score;
  final int total;
 
  ResultScreen({
    super.key,
    required this.userName,
    required this.email,
    required this.category,
    required this.score,
    required this.total,
  }) {
    leaderboard.add({
      'name': userName,
      'category': category,
      'score': score,
      'total': total,
    });
  }
 
  @override
  Widget build(BuildContext context) {
    double percentage = (score / total) * 100;
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 100,
                color: Colors.amber,
              ),
              const SizedBox(height: 20),
              const Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 15),
              Text(userName, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text(
                '$score / $total',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(1)}% Score',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(
                          userName: userName,
                          email: email,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('PLAY AGAIN'),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LeaderboardScreen(),
                    ),
                  );
                },
                child: const Text('VIEW LEADERBOARD'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
// LEADERBOARD SCREEN
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sorted = List.from(leaderboard);
 
    sorted.sort((a, b) {
      double first = a['score'] / a['total'];
      double second = b['score'] / b['total'];
      return second.compareTo(first);
    });
 
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: sorted.isEmpty
          ? const Center(
              child: Text(
                'No scores available yet!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                var item = sorted[index];
 
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(item['name']),
                    subtitle: Text(item['category']),
                    trailing: Text(
                      '${item['score']}/${item['total']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

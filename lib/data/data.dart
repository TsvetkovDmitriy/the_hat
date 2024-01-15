class Game {
  bool gameStarted = false;
  bool roundStarted =false;
  int currentRound = 0;
  List<Team> teamList = [
    Team(),
    Team(name: "Команда 2")
  ];
  int currentTurn = 0;
  Try currentTry = Try();
  List<String> mainWordList = [];
  List<String> currentRoundWordList = [];
}

class Team {
  Team ({this.name = "Команда 1"});
  String name;
  int score = 0;
  List<Player> playersList = [
    Player(),
    Player(name: "Игрок 2")
  ];
  int currentTurn = 0;
  List<String> currentWordList = [];
}

class Player {
  Player ({this.name = "Игрок 1"});
  String name;
  int personalScore = 0;
}

class Try {
  Player player = Player();
  Team team = Team();
  List<String> okWord = [];
  List<String> noOkWord = [];
  String currentWord = '';
}
import 'dart:collection';

class TrieNode {
  bool isEndOfWord = false;
  Map<String, TrieNode> children = {};
}

class Trie {
  TrieNode root = TrieNode();

  void insert(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!node.children.containsKey(char)) {
        node.children[char] = TrieNode();
      }
      node = node.children[char]!;
    }
    node.isEndOfWord = true;
  }

  bool search(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!node.children.containsKey(char)) {
        return false;
      }
      node = node.children[char]!;
    }
    return node.isEndOfWord;
  }
}


class ACNode {
  String character;
  bool isEndOfWord= false;
  Map<String, ACNode> children= {};
  ACNode? failure= null;

  ACNode(this.character);

}

class AhoCorasick {
  ACNode root  = ACNode('');


  void insert(String word) {
    ACNode currentNode = root;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!currentNode.children.containsKey(char)) {
        currentNode.children[char] = ACNode(char);
      }
      currentNode = currentNode.children[char]!;
    }

    currentNode.isEndOfWord = true;
  }

  void buildFailureLinks() {
    Queue<ACNode> queue = Queue<ACNode>();

    // 设置根节点的failure指针为null，并将根节点的子节点加入队列
    root.failure = null;
    queue.addAll(root.children.values);

    while (queue.isNotEmpty) {
      ACNode currentNode = queue.removeFirst();

      // 遍历当前节点的子节点
      for (ACNode childNode in currentNode.children.values) {
        queue.add(childNode);

        ACNode? failureNode = currentNode.failure;

        // 在failure链上搜索匹配的子节点
        while (failureNode != null && !failureNode.children.containsKey(childNode.character)) {
          failureNode = failureNode.failure;
        }

        if (failureNode != null) {
          childNode.failure = failureNode.children[childNode.character];
        } else {
          childNode.failure = root; // 如果没有匹配，将failure指针指向根节点
        }
      }
    }
  }

  List<String> findMatches(String text) {
    List<String> matches = [];

    ACNode currentNode = root;

    for (int i = 0; i < text.length; i++) {
      String char = text[i];

      // 在failure链上搜索匹配的子节点
      while (!currentNode.children.containsKey(char) && currentNode != root) {
        currentNode = currentNode.failure!;
      }

      if (currentNode.children.containsKey(char)) {
        currentNode = currentNode.children[char]!;
      } else {
        continue;
      }

      // 检查当前节点是否为单词结尾
      if (currentNode.isEndOfWord) {
        String match = _getFullMatch(i, text);
        matches.add(match);
      }

      // 检查failure链上的其他可能匹配
      ACNode? failureNode = currentNode.failure;
      while (failureNode != null) {
        if (failureNode.isEndOfWord) {
          String match = _getFullMatch(i, text);
          matches.add(match);
        }
        failureNode = failureNode.failure;
      }
    }

    return matches;
  }

  String _getFullMatch(int index, String text) {
    int start = index;
    while (start >= 0 && !_isWordBoundary(text[start])) {
      start--;
    }
    int end = index;
    while (end < text.length && !_isWordBoundary(text[end])) {
      end++;
    }
    return text.substring(start + 1, end);
  }

  bool _isWordBoundary(String char) {
    return char == ' ' || char == '\n' || char == '\t';
  }
}
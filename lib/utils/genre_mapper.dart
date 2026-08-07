const Map<String, String> genreMapper = {
  "Biography & Autobiography": "Biography",
  "Historical fiction": "Historical Fiction",
  "Comics & Graphic Novels": "Comics & Graphic Novels",
  "Children's stories": "Young Adult",
  "Cancer in adolescence": "Young Adult",
  "Authors, Hindi": "Literature",
  "Travel": "Travel",
  "History": "History",
  "Literature": "Literary Explorer",
};

String normalizeGenre(String genre) {
  return genreMapper[genre] ?? genre;
}

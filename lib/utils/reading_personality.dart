const Map<String, String> readingPersonalities = {
  "Fantasy": "Fantasy Explorer🧙",
  "Adventure": "Adventure Seeker🏕️",
  "Romance": "Hopeless Romantic❤️",
  "Mystery": "Master Detective🕵️",
  "Thriller": "Thrill Seeker🔥",
  "Horror": "Fearless Soul👻",
  "Science Fiction": "Future Dreamer🚀",
  "Young Adult": "Young Dreamer✨",
  "Historical Fiction": "History Wanderer🏛️",
  "Biography": "Life Explorer🌍",
  "Self-Help": "Growth Seeker🌱",
  "Business & Economics": "Strategic Thinker💼",
  "Philosophy": "Deep Thinker🧠",
  "Psychology": "Mind Explorer🧩",
  "Poetry": "Poetic Soul🌸",
  "Comics & Graphic Novels": "Visual Storyteller🎨",
};
String getReadingPersonality(String genre) {
  return readingPersonalities[genre] ?? "Curious Reader📚";
}

String sanitizeComment(String comment) {
  // Trim whitespace
  String sanitizedComment = comment.trim();

  // Replace multiple spaces with a single space
  sanitizedComment = sanitizedComment.replaceAll(RegExp(r'\s+'), ' ');

  // Escape HTML to prevent XSS
  sanitizedComment = sanitizedComment.replaceAll('<', '&lt;').replaceAll('>', '&gt;');

  // Optionally, implement a profanity filter here
  // Example: sanitizedComment = filterProfanity(sanitizedComment);

  return sanitizedComment;
}

package com.example.SummarizerApplication.Service;



import org.springframework.stereotype.Service;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.jsoup.Jsoup;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SummarizerService {

    private List<String> currentSentences = new ArrayList<>();

    public String extractTextFromPdf(File pdfFile) throws IOException {
        try (PDDocument document = PDDocument.load(pdfFile)) {
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document);
            splitIntoSentences(text);
            return text;
        }
    }

    public String extractTextFromUrl(String url) throws IOException {
        String text = Jsoup.connect(url).get().text();
        splitIntoSentences(text);
        return text;
    }

    private void splitIntoSentences(String text) {
        this.currentSentences = Arrays.asList(text.split("(?<=[.!?])\\s+"));
    }

    public String summarize(String text, int maxSentences) {
        String[] sentences = text.split("(?<=[.!?])\\s+");
        Map<String, Integer> freq = new HashMap<>();

        for (String sentence : sentences) {
            for (String word : sentence.toLowerCase().split("\\W+")) {
                freq.put(word, freq.getOrDefault(word, 0) + 1);
            }
        }

        // Score sentences by word frequency
        Map<String, Integer> sentenceScore = new HashMap<>();
        for (String sentence : sentences) {
            int score = 0;
            for (String word : sentence.toLowerCase().split("\\W+")) {
                score += freq.getOrDefault(word, 0);
            }
            sentenceScore.put(sentence, score);
        }

        return sentenceScore.entrySet().stream()
                .sorted((a, b) -> b.getValue() - a.getValue())
                .limit(maxSentences)
                .map(Map.Entry::getKey)
                .collect(Collectors.joining(" "));
    }

    // Q&A: naive TF-IDF similarity
    public String answerQuestion(String question) {
        if (currentSentences.isEmpty()) {
            return "Please upload a document or URL first.";
        }

        String[] qWords = question.toLowerCase().split("\\W+");
        int bestScore = -1;
        String bestSentence = "Sorry, no answer found.";

        for (String sentence : currentSentences) {
            int score = 0;
            for (String word : qWords) {
                if (sentence.toLowerCase().contains(word)) {
                    score++;
                }
            }
            if (score > bestScore) {
                bestScore = score;
                bestSentence = sentence;
            }
        }
        return bestSentence;
    }
}

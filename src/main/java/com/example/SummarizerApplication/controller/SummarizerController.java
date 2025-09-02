package com.example.SummarizerApplication.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.SummarizerApplication.Service.*;

import java.io.File;

@RestController
public class SummarizerController {

    @Autowired
    private SummarizerService summarizerService;

    @GetMapping("/trail")
    @ResponseBody // This one returns raw text
    public String trail() {
        return "HI Welcome";
    }

    @GetMapping({"/", "/home", "/index"})
    public ModelAndView homePage() {
        return new ModelAndView("index");  // resolves to /WEB-INF/jsp/index.jsp
    }

    @PostMapping("/summarizePdf")
    public ModelAndView summarizePdf(@RequestParam("file") MultipartFile file, Model model) {
        try {
            File temp = File.createTempFile("upload", ".pdf");
            file.transferTo(temp);
            String text = summarizerService.extractTextFromPdf(temp);
            String summary = summarizerService.summarize(text, 5);
            model.addAttribute("summary", summary);
        } catch (Exception e) {
            model.addAttribute("summary", "Error: " + e.getMessage());
        }
        return new ModelAndView ("result"); // Resolves to result.jsp
    }

    @PostMapping("/summarizeUrl")
    public ModelAndView summarizeUrl(@RequestParam("url") String url, Model model) {
        try {
            String text = summarizerService.extractTextFromUrl(url);
            String summary = summarizerService.summarize(text, 5);
            model.addAttribute("summary", summary);
        } catch (Exception e) {
            model.addAttribute("summary", "Error: " + e.getMessage());
        }
        return new ModelAndView ("result"); // Resolves to result.jsp
    }

    @PostMapping("/ask")
    public ModelAndView askQuestion(@RequestParam("question") String question, Model model) {
        try {
            String answer = summarizerService.answerQuestion(question);
            model.addAttribute("answer", answer);
        } catch (Exception e) {
            model.addAttribute("answer", "Error: " + e.getMessage());
        }
        return new ModelAndView ("qa");
    }

}

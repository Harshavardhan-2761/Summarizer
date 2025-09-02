<img width="1536" height="1024" alt="ChatGPT Image Sep 2, 2025, 11_25_11 AM" src="https://github.com/user-attachments/assets/4dad7057-1f9a-4e70-98cf-24303098e8e2" />

# 📑 SummarizerApplication  

✨ A lightweight **Spring Boot WebApp (WAR)** to **Summarize PDFs, URLs, and Q&A** with a clean **JSP UI** + **PWA support**.  

---

## 🚀 What It Does
- 📂 **Upload PDFs** → Extract + Summarize  
- 🔗 **Paste URLs** → Fetch + Summarize content  
- ❓ **Ask Questions** → Quick Q&A from extracted text  
- 📱 **Installable PWA** → Works like a native app  

---

## 🛠️ Tech Stack
- ☕ **Java 17** + **Spring Boot 3.x**  
- 🛠️ **Maven 3.5.4+**  
- 📑 **JSP + JSTL** (UI)  
- 📘 **Apache PDFBox** (PDF parsing)  
- 🌐 **JSoup** (HTML parsing)  
- 📱 **PWA** (manifest + service worker)  

---

## 📂 Structure
SummarizerApplication/
├── controller/        # MVC Controllers
├── service/           # Summarizer & QnA logic
├── SummarizerApplication.java
├── webapp/
│   ├── WEB-INF/jsp/   # JSP Views
│   ├── manifest.json  # PWA
│   └── sw\.js          # Service Worker
└── pom.xml


## ⚡ Setup
git clone https://github.com/Harshavardhan-2761/SummarizerApplication.git
cd SummarizerApplication
mvn clean package
* Deploy WAR on **Tomcat** or run embedded server
* Open 👉 `http://localhost:9090/sum/`

---

## 📱 Install as PWA
1. Open in Chrome/Edge/Android
2. Click **Install App / Add to Home Screen**
3. Use like a native app 🚀

---

##  🖼️Demo Screenshot  
<img width="1497" height="868" alt="image" src="https://github.com/user-attachments/assets/30b85db9-2c70-4f4f-888e-31ff91e3b6d6" />

---

## 👨‍💻 Author
**Harsha Vardhan T**
🔗 [GitHub](https://github.com/Harshavardhan-2761)
📧 [tvenkataharsha@gmail.com](mailto:tvenkataharsha@gmail.com)

---

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Document Summarizer | Smart Analysis Tool</title>
    
    <!-- PWA Configuration -->
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#667eea">
    <link rel="apple-touch-icon" href="/icons/icon-192x192.png">
    
    <!-- External Libraries -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.32/sweetalert2.all.min.js"></script>
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            
            --bg-primary: #ffffff;
            --bg-secondary: #f8fafc;
            --bg-card: #ffffff;
            --text-primary: #1a202c;
            --text-secondary: #4a5568;
            --border-color: #e2e8f0;
            --shadow-light: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --shadow-heavy: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        [data-theme="dark"] {
            --bg-primary: #0f172a;
            --bg-secondary: #1e293b;
            --bg-card: #334155;
            --text-primary: #f1f5f9;
            --text-secondary: #cbd5e1;
            --border-color: #475569;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            transition: all 0.3s ease;
        }

        /* Preloader */
        .preloader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease-out;
        }

        .preloader.fade-out {
            opacity: 0;
            pointer-events: none;
        }

        .loader {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Header */
        .header {
            background: var(--bg-card);
            padding: 1rem 0;
            box-shadow: var(--shadow-light);
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.5rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .theme-toggle {
            background: var(--bg-secondary);
            border: 2px solid var(--border-color);
            border-radius: 50px;
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .theme-toggle:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .hero-section {
            text-align: center;
            margin-bottom: 3rem;
            padding: 2rem;
            background: var(--bg-card);
            border-radius: 20px;
            box-shadow: var(--shadow-light);
        }

        .hero-title {
            font-size: clamp(2rem, 5vw, 3.5rem);
            font-weight: 800;
            margin-bottom: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }

        /* Cards */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .card {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-heavy);
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .pdf-icon { background: var(--danger-gradient); }
        .url-icon { background: var(--success-gradient); }
        .qa-icon { background: var(--warning-gradient); }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        .card-description {
            color: var(--text-secondary);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        /* Forms */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .form-input {
            width: 100%;
            padding: 1rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            background: var(--bg-secondary);
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }

        .file-input {
            position: absolute;
            left: -9999px;
        }

        .file-input-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem;
            border: 2px dashed var(--border-color);
            border-radius: 12px;
            background: var(--bg-secondary);
            cursor: pointer;
            transition: all 0.3s ease;
            min-height: 120px;
            flex-direction: column;
        }

        .file-input-label:hover {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
        }

        .file-input-icon {
            font-size: 2rem;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
        }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            justify-content: center;
            min-width: 140px;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-secondary {
            background: var(--secondary-gradient);
            color: white;
        }

        .btn-success {
            background: var(--success-gradient);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Progress Bar */
        .progress-container {
            display: none;
            margin-top: 1rem;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: var(--bg-secondary);
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: var(--primary-gradient);
            border-radius: 4px;
            transition: width 0.3s ease;
            animation: progress-animation 2s ease-in-out infinite;
        }

        @keyframes progress-animation {
            0%, 100% { width: 0%; }
            50% { width: 100%; }
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 2rem;
            color: var(--text-secondary);
            border-top: 1px solid var(--border-color);
            margin-top: 4rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .cards-grid {
                grid-template-columns: 1fr;
            }
            
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .hero-section {
                margin-bottom: 2rem;
                padding: 1.5rem;
            }
            
            .card {
                padding: 1.5rem;
            }
        }

        /* Error Animations */
        .shake {
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        /* Success Animations */
        .bounce-in {
            animation: bounceIn 0.6s ease-out;
        }

        @keyframes bounceIn {
            0% { transform: scale(0.3); opacity: 0; }
            50% { transform: scale(1.05); opacity: 1; }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
    <!-- Preloader -->
    <div class="preloader" id="preloader">
        <div class="loader"></div>
    </div>

    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-brain"></i>
                <span>AI Summarizer</span>
            </div>
            <button class="theme-toggle" id="themeToggle">
                <i class="fas fa-moon" id="themeIcon"></i>
                <span id="themeText">Dark Mode</span>
            </button>
        </div>
    </header>

    <!-- Main Container -->
    <div class="container">
        <!-- Hero Section -->
        <section class="hero-section animate__animated animate__fadeInUp">
            <h1 class="hero-title">Smart Document Analysis</h1>
            <p class="hero-subtitle">
                Transform your documents and web content into concise, intelligent summaries. 
                Ask questions and get instant answers powered by AI.
            </p>
        </section>

        <!-- Cards Grid -->
        <div class="cards-grid">
            <!-- PDF Upload Card -->
            <div class="card animate__animated animate__fadeInUp" style="animation-delay: 0.1s">
                <div class="card-header">
                    <div class="card-icon pdf-icon">
                        <i class="fas fa-file-pdf"></i>
                    </div>
                    <div>
                        <h3 class="card-title">PDF Summarizer</h3>
                    </div>
                </div>
                <p class="card-description">
                    Upload your PDF documents and get intelligent summaries instantly. 
                    Perfect for research papers, reports, and lengthy documents.
                </p>
                
                <form id="pdfForm" action="summarizePdf" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <div class="file-input-wrapper">
                            <input type="file" name="file" id="pdfFile" class="file-input" 
                                   accept="application/pdf" required>
                            <label for="pdfFile" class="file-input-label">
                                <i class="fas fa-cloud-upload-alt file-input-icon"></i>
                                <span>Choose PDF File</span>
                                <small>or drag and drop here</small>
                            </label>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary" id="pdfSubmit">
                        <i class="fas fa-magic"></i>
                        <span>Summarize PDF</span>
                    </button>
                    
                    <div class="progress-container" id="pdfProgress">
                        <div class="progress-bar">
                            <div class="progress-fill"></div>
                        </div>
                        <p style="text-align: center; margin-top: 0.5rem; color: var(--text-secondary);">
                            Processing your document...
                        </p>
                    </div>
                </form>
            </div>

            <!-- URL Summarizer Card -->
            <div class="card animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
                <div class="card-header">
                    <div class="card-icon url-icon">
                        <i class="fas fa-globe"></i>
                    </div>
                    <div>
                        <h3 class="card-title">URL Summarizer</h3>
                    </div>
                </div>
                <p class="card-description">
                    Extract and summarize content from any web page. 
                    Get key insights from articles, blogs, and online resources.
                </p>
                
                <form id="urlForm" action="summarizeUrl" method="post">
                    <div class="form-group">
                        <label for="urlInput" class="form-label">
                            <i class="fas fa-link"></i> Website URL
                        </label>
                        <input type="url" name="url" id="urlInput" class="form-input" 
                               placeholder="https://example.com/article" required>
                    </div>
                    
                    <button type="submit" class="btn btn-secondary" id="urlSubmit">
                        <i class="fas fa-external-link-alt"></i>
                        <span>Summarize URL</span>
                    </button>
                    
                    <div class="progress-container" id="urlProgress">
                        <div class="progress-bar">
                            <div class="progress-fill"></div>
                        </div>
                        <p style="text-align: center; margin-top: 0.5rem; color: var(--text-secondary);">
                            Fetching and analyzing content...
                        </p>
                    </div>
                </form>
            </div>

            <!-- Q&A Card -->
            <div class="card animate__animated animate__fadeInUp" style="animation-delay: 0.3s">
                <div class="card-header">
                    <div class="card-icon qa-icon">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <div>
                        <h3 class="card-title">Ask Questions</h3>
                    </div>
                </div>
                <p class="card-description">
                    Get instant answers to your questions. Our AI assistant is ready to help 
                    with information, explanations, and insights.
                </p>
                
                <form id="qaForm" action="ask" method="post">
                    <div class="form-group">
                        <label for="questionInput" class="form-label">
                            <i class="fas fa-comments"></i> Your Question
                        </label>
                        <input type="text" name="question" id="questionInput" class="form-input" 
                               placeholder="What would you like to know?" required>
                    </div>
                    
                    <button type="submit" class="btn btn-success" id="qaSubmit">
                        <i class="fas fa-paper-plane"></i>
                        <span>Ask Question</span>
                    </button>
                    
                    <div class="progress-container" id="qaProgress">
                        <div class="progress-bar">
                            <div class="progress-fill"></div>
                        </div>
                        <p style="text-align: center; margin-top: 0.5rem; color: var(--text-secondary);">
                            Thinking and generating response...
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 AI Document Summarizer. Powered by Advanced Machine Learning.</p>
    </footer>

    <script>
        // Constants for string concatenation
        const MESSAGES = {
            SUCCESS: {
                UPLOAD: 'File uploaded successfully!',
                URL_VALID: 'URL is valid and ready to process!',
                QUESTION_SUBMITTED: 'Question submitted successfully!'
            },
            ERROR: {
                NETWORK: 'Network error occurred. Please check your connection.',
                SERVER: 'Server error occurred. Please try again later.',
                INVALID_FILE: 'Please select a valid PDF file.',
                INVALID_URL: 'Please enter a valid URL.',
                EMPTY_QUESTION: 'Please enter a question.',
                TIMEOUT: 'Request timed out. Please try again.',
                UNKNOWN: 'An unexpected error occurred.'
            },
            INFO: {
                PROCESSING: 'Processing your request...',
                PLEASE_WAIT: 'Please wait while we process your request.'
            }
        };

        const THEMES = {
            LIGHT: 'light',
            DARK: 'dark'
        };

        // DOM Elements
        const elements = {
            preloader: document.getElementById('preloader'),
            themeToggle: document.getElementById('themeToggle'),
            themeIcon: document.getElementById('themeIcon'),
            themeText: document.getElementById('themeText'),
            pdfForm: document.getElementById('pdfForm'),
            urlForm: document.getElementById('urlForm'),
            qaForm: document.getElementById('qaForm'),
            pdfFile: document.getElementById('pdfFile'),
            urlInput: document.getElementById('urlInput'),
            questionInput: document.getElementById('questionInput')
        };

        // Initialize Application
        document.addEventListener('DOMContentLoaded', function() {
            initializeApp();
        });

        function initializeApp() {
            hidePreloader();
            initializeTheme();
            setupEventListeners();
            setupServiceWorker();
            setupFormValidation();
        }

        // Preloader Functions
        function hidePreloader() {
            setTimeout(() => {
                elements.preloader.classList.add('fade-out');
                setTimeout(() => {
                    elements.preloader.style.display = 'none';
                }, 500);
            }, 1500);
        }

        // Theme Management
        function initializeTheme() {
            const savedTheme = localStorage.getItem('theme') || THEMES.LIGHT;
            setTheme(savedTheme);
        }

        function setTheme(theme) {
            document.documentElement.setAttribute('data-theme', theme);
            updateThemeButton(theme);
            localStorage.setItem('theme', theme);
        }

        function updateThemeButton(theme) {
            const isDark = theme === THEMES.DARK;
            elements.themeIcon.className = isDark ? 'fas fa-sun' : 'fas fa-moon';
            elements.themeText.textContent = isDark ? 'Light Mode' : 'Dark Mode';
        }

        function toggleTheme() {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            const newTheme = currentTheme === THEMES.DARK ? THEMES.LIGHT : THEMES.DARK;
            setTheme(newTheme);
        }

        // Event Listeners
        function setupEventListeners() {
            elements.themeToggle.addEventListener('click', toggleTheme);
            
            // File input change event
            elements.pdfFile.addEventListener('change', handleFileSelect);
            
            // Form submissions
            elements.pdfForm.addEventListener('submit', handlePdfSubmit);
            elements.urlForm.addEventListener('submit', handleUrlSubmit);
            elements.qaForm.addEventListener('submit', handleQaSubmit);
            
            // Input validations
            elements.urlInput.addEventListener('blur', validateUrl);
            elements.questionInput.addEventListener('input', validateQuestion);
        }

        // File Handling
        function handleFileSelect(event) {
            const file = event.target.files[0];
            const label = event.target.nextElementSibling;
            
            if (file) {
                const fileName = file.name;
                const fileSize = (file.size / (1024 * 1024)).toFixed(2) + ' MB';
                label.innerHTML = 
    '<i class="fas fa-file-pdf file-input-icon" style="color: #e53e3e;"></i>' +
    '<span>' + fileName + '</span>' +
    '<small>' + fileSize + '</small>';

                
                if (file.type !== 'application/pdf') {
                    showError(MESSAGES.ERROR.INVALID_FILE);
                    event.target.value = '';
                } else {
                    showSuccess(MESSAGES.SUCCESS.UPLOAD);
                }
            }
        }

        // Form Submissions
        function handlePdfSubmit(event) {
            event.preventDefault();
            
            const fileInput = elements.pdfFile;
            if (!fileInput.files[0]) {
                showError(MESSAGES.ERROR.INVALID_FILE);
                addShakeAnimation(fileInput.closest('.card'));
                return;
            }
            
            showProgress('pdfProgress');
            submitFormWithErrorHandling(elements.pdfForm);
        }

        function handleUrlSubmit(event) {
            event.preventDefault();
            
            const url = elements.urlInput.value.trim();
            if (!isValidUrl(url)) {
                showError(MESSAGES.ERROR.INVALID_URL);
                addShakeAnimation(elements.urlInput);
                return;
            }
            
            showProgress('urlProgress');
            submitFormWithErrorHandling(elements.urlForm);
        }

        function handleQaSubmit(event) {
            event.preventDefault();
            
            const question = elements.questionInput.value.trim();
            if (!question) {
                showError(MESSAGES.ERROR.EMPTY_QUESTION);
                addShakeAnimation(elements.questionInput);
                return;
            }
            
            showProgress('qaProgress');
            submitFormWithErrorHandling(elements.qaForm);
        }

        // Form Validation
        function setupFormValidation() {
            // Real-time validation can be added here
        }

        function validateUrl() {
            const url = elements.urlInput.value.trim();
            if (url && isValidUrl(url)) {
                elements.urlInput.style.borderColor = '#48bb78';
                showSuccess(MESSAGES.SUCCESS.URL_VALID);
            }
        }

        function validateQuestion() {
            const question = elements.questionInput.value.trim();
            if (question.length > 10) {
                elements.questionInput.style.borderColor = '#48bb78';
            }
        }

        function isValidUrl(string) {
            try {
                const url = new URL(string);
                return url.protocol === 'http:' || url.protocol === 'https:';
            } catch (_) {
                return false;
            }
        }

        // Progress and Error Handling
        function showProgress(progressId) {
            const progressContainer = document.getElementById(progressId);
            if (progressContainer) {
                progressContainer.style.display = 'block';
            }
        }

        function hideProgress(progressId) {
            const progressContainer = document.getElementById(progressId);
            if (progressContainer) {
                progressContainer.style.display = 'none';
            }
        }

        function submitFormWithErrorHandling(form) {
            const formData = new FormData(form);
            const action = form.getAttribute('action');
            const method = form.getAttribute('method') || 'POST';
            
            fetch(action, {
                method: method.toUpperCase(),
                body: method.toUpperCase() === 'POST' ? formData : null
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ': ' + getErrorMessage(response.status));
                }
                return response.text();
            })
            .then(html => {
                // Success - navigate to result page
                document.open();
                document.write(html);
                document.close();
            })
            .catch(error => {
                console.error('Form submission error:', error);
                hideAllProgress();
                
                if (error.message.includes('HTTP')) {
                    showError(error.message);
                } else if (error.name === 'TypeError') {
                    showError(MESSAGES.ERROR.NETWORK);
                } else {
                    showError(MESSAGES.ERROR.UNKNOWN);
                }
            });
        }

        function getErrorMessage(status) {
            const errorMessages = {
                400: 'Bad Request - Please check your input',
                401: 'Unauthorized - Please log in',
                403: 'Forbidden - Access denied',
                404: 'Not Found - The requested resource was not found',
                405: 'Method Not Allowed - Invalid request method',
                408: 'Request Timeout - The request took too long',
                500: 'Internal Server Error - Please try again later',
                502: 'Bad Gateway - Server is temporarily unavailable',
                503: 'Service Unavailable - Server is under maintenance',
                504: 'Gateway Timeout - Server response timeout'
            };
            
            return errorMessages[status] || MESSAGES.ERROR.UNKNOWN;
        }

        function hideAllProgress() {
            const progressContainers = document.querySelectorAll('.progress-container');
            progressContainers.forEach(container => {
                container.style.display = 'none';
            });
        }

        // Animations
        function addShakeAnimation(element) {
            element.classList.add('shake');
            setTimeout(() => {
                element.classList.remove('shake');
            }, 500);
        }

        // Alert Functions
        function showSuccess(message) {
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: message,
                timer: 3000,
                showConfirmButton: false,
                toast: true,
                position: 'top-end',
                background: 'var(--bg-card)',
                color: 'var(--text-primary)'
            });
        }

        function showError(message) {
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: message,
                confirmButtonColor: '#e53e3e',
                background: 'var(--bg-card)',
                color: 'var(--text-primary)'
            });
        }

        function showInfo(message) {
            Swal.fire({
                icon: 'info',
                title: 'Information',
                text: message,
                timer: 3000,
                showConfirmButton: false,
                toast: true,
                position: 'top-end',
                background: 'var(--bg-card)',
                color: 'var(--text-primary)'
            });
        }

        // Service Worker Registration
        function setupServiceWorker() {
            if ('serviceWorker' in navigator) {
                navigator.serviceWorker.register('/sw.js')
                    .then(registration => {
                        console.log('ServiceWorker registration successful');
                    })
                    .catch(error => {
                        console.log('ServiceWorker registration failed');
                    });
            }
        }

        // Drag and Drop functionality
        function setupDragAndDrop() {
            const dropZones = document.querySelectorAll('.file-input-label');
            
            dropZones.forEach(dropZone => {
                dropZone.addEventListener('dragover', handleDragOver);
                dropZone.addEventListener('dragleave', handleDragLeave);
                dropZone.addEventListener('drop', handleDrop);
            });
        }

        function handleDragOver(event) {
            event.preventDefault();
            event.currentTarget.style.borderColor = '#667eea';
            event.currentTarget.style.backgroundColor = 'rgba(102, 126, 234, 0.1)';
        }

        function handleDragLeave(event) {
            event.preventDefault();
            event.currentTarget.style.borderColor = 'var(--border-color)';
            event.currentTarget.style.backgroundColor = 'var(--bg-secondary)';
        }

        function handleDrop(event) {
            event.preventDefault();
            handleDragLeave(event);
            
            const files = event.dataTransfer.files;
            const fileInput = event.currentTarget.previousElementSibling;
            
            if (files.length > 0) {
                fileInput.files = files;
                handleFileSelect({ target: fileInput });
            }
        }

        // Initialize drag and drop when DOM is loaded
        document.addEventListener('DOMContentLoaded', function() {
            setupDragAndDrop();
        });
    </script>
</body>
</html>
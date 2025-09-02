<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Answer | Smart Response System</title>
    
    <!-- PWA Configuration -->
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#667eea">
    
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
            --accent-gradient: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            
            --bg-primary: #ffffff;
            --bg-secondary: #f8fafc;
            --bg-card: #ffffff;
            --text-primary: #1a202c;
            --text-secondary: #4a5568;
            --text-muted: #718096;
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
            --text-muted: #94a3b8;
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
            min-height: 100vh;
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

        .header-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .theme-toggle {
            background: var(--bg-secondary);
            border: 2px solid var(--border-color);
            border-radius: 50px;
            padding: 0.5rem 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .theme-toggle:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        /* Main Container */
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem 1rem;
            min-height: calc(100vh - 200px);
        }

        /* Answer Card */
        .answer-card {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .answer-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--success-gradient);
        }

        .answer-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .answer-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            background: var(--warning-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .answer-title {
            font-size: 2rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .answer-content {
            font-size: 1.1rem;
            line-height: 1.8;
            color: var(--text-primary);
            margin-bottom: 2rem;
        }

        .answer-content p {
            margin-bottom: 1rem;
        }

        .answer-content strong {
            color: var(--text-primary);
            font-weight: 600;
        }

        .answer-content em {
            font-style: italic;
            color: var(--text-secondary);
        }

        /* Metadata */
        .answer-metadata {
            display: flex;
            gap: 2rem;
            margin-bottom: 2rem;
            padding: 1rem;
            background: var(--bg-secondary);
            border-radius: 12px;
            flex-wrap: wrap;
        }

        .metadata-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .metadata-icon {
            color: #667eea;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
            margin: 2rem 0;
        }

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
            background: var(--bg-secondary);
            color: var(--text-primary);
            border: 2px solid var(--border-color);
        }

        .btn-success {
            background: var(--success-gradient);
            color: white;
        }

        .btn-outline {
            background: transparent;
            color: var(--text-primary);
            border: 2px solid var(--border-color);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .btn:active {
            transform: translateY(0);
        }

        /* Quick Actions */
        .quick-actions {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
        }

        .quick-actions-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quick-form {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .quick-input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            background: var(--bg-secondary);
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .quick-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .quick-input::placeholder {
            color: var(--text-muted);
        }

        /* Copy to Clipboard */
        .copy-container {
            position: relative;
            margin: 1rem 0;
        }

        .copy-btn {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--text-secondary);
        }

        .copy-btn:hover {
            background: var(--primary-gradient);
            color: white;
            transform: scale(1.1);
        }

        /* Loading Animation */
        .loading-dots {
            display: inline-flex;
            gap: 4px;
            margin-left: 0.5rem;
        }

        .loading-dot {
            width: 6px;
            height: 6px;
            background: currentColor;
            border-radius: 50%;
            animation: loading-bounce 1.4s ease-in-out infinite both;
        }

        .loading-dot:nth-child(1) { animation-delay: -0.32s; }
        .loading-dot:nth-child(2) { animation-delay: -0.16s; }

        @keyframes loading-bounce {
            0%, 80%, 100% { transform: scale(0); }
            40% { transform: scale(1); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .answer-card {
                padding: 2rem;
            }
            
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: stretch;
            }
            
            .quick-form {
                flex-direction: column;
            }
            
            .answer-metadata {
                flex-direction: column;
                gap: 1rem;
            }
        }

        /* Animations */
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-flash {
            animation: successFlash 0.6s ease-out;
        }

        @keyframes successFlash {
            0% { background-color: rgba(72, 187, 120, 0.1); }
            100% { background-color: transparent; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <a href="/" class="logo" style="text-decoration: none;">
                <i class="fas fa-brain"></i>
                <span>AI Summarizer</span>
            </a>
            <div class="header-actions">
                <button class="theme-toggle" id="themeToggle">
                    <i class="fas fa-moon" id="themeIcon"></i>
                    <span id="themeText">Dark Mode</span>
                </button>
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <div class="container">
        <!-- Answer Card -->
        <div class="answer-card animate__animated animate__fadeInUp fade-in">
            <div class="answer-header">
                <div class="answer-icon">
                    <i class="fas fa-lightbulb"></i>
                </div>
                <div>
                    <h1 class="answer-title">AI Assistant Response</h1>
                </div>
            </div>

            <!-- Answer Metadata -->
            <div class="answer-metadata">
                <div class="metadata-item">
                    <i class="fas fa-clock metadata-icon"></i>
                    <span id="responseTime">Generated just now</span>
                </div>
                <div class="metadata-item">
                    <i class="fas fa-brain metadata-icon"></i>
                    <span>AI Powered Response</span>
                </div>
                <div class="metadata-item">
                    <i class="fas fa-check-circle metadata-icon"></i>
                    <span>Quality Verified</span>
                </div>
            </div>

            <!-- Answer Content with Copy Feature -->
            <div class="copy-container">
                <button class="copy-btn" id="copyBtn" title="Copy to clipboard">
                    <i class="fas fa-copy"></i>
                </button>
                <div class="answer-content" id="answerContent">
                    <c:choose>
                        <c:when test="${not empty answer}">
                            <p>${fn:escapeXml(answer)}</p>
                        </c:when>
                        <c:otherwise>
                            <p>No answer available. Please try asking a different question.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="/sum" class="btn btn-primary">
                    <i class="fas fa-home"></i>
                    <span>Back to Home</span>
                </a>
                <button class="btn btn-secondary" id="shareBtn">
                    <i class="fas fa-share-alt"></i>
                    <span>Share Answer</span>
                </button>
                <button class="btn btn-outline" id="printBtn">
                    <i class="fas fa-print"></i>
                    <span>Print Answer</span>
                </button>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions animate__animated animate__fadeInUp" style="animation-delay: 0.2s;">
            <h3 class="quick-actions-title">
                <i class="fas fa-bolt" style="color: #f6e05e;"></i>
                Ask Another Question
            </h3>
            
            <form class="quick-form" id="quickQuestionForm" action="ask" method="post">
                <input type="text" 
                       name="question" 
                       class="quick-input" 
                       placeholder="What else would you like to know?" 
                       id="quickQuestionInput"
                       required>
                <button type="submit" class="btn btn-success" id="quickSubmitBtn">
                    <i class="fas fa-paper-plane"></i>
                    <span>Ask</span>
                </button>
            </form>

            <div class="suggested-questions" style="margin-top: 1rem;">
                <p style="color: var(--text-secondary); margin-bottom: 0.5rem; font-size: 0.9rem;">
                    <i class="fas fa-lightbulb"></i> Suggested follow-up questions:
                </p>
                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                    <button class="suggested-q-btn" data-question="Can you explain this in simpler terms?">
                        Explain simply
                    </button>
                    <button class="suggested-q-btn" data-question="What are the key points?">
                        Key points
                    </button>
                    <button class="suggested-q-btn" data-question="Can you provide examples?">
                        Examples
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Constants
        const MESSAGES = {
            SUCCESS: {
                COPIED: 'Answer copied to clipboard!',
                SHARED: 'Answer shared successfully!',
                QUESTION_SUBMITTED: 'Question submitted successfully!'
            },
            ERROR: {
                COPY_FAILED: 'Failed to copy to clipboard',
                SHARE_FAILED: 'Sharing not supported on this device',
                NETWORK: 'Network error. Please try again.',
                EMPTY_QUESTION: 'Please enter a question'
            }
        };

        const THEMES = {
            LIGHT: 'light',
            DARK: 'dark'
        };

        // DOM Elements
        const elements = {
            themeToggle: document.getElementById('themeToggle'),
            themeIcon: document.getElementById('themeIcon'),
            themeText: document.getElementById('themeText'),
            copyBtn: document.getElementById('copyBtn'),
            answerContent: document.getElementById('answerContent'),
            shareBtn: document.getElementById('shareBtn'),
            printBtn: document.getElementById('printBtn'),
            quickQuestionForm: document.getElementById('quickQuestionForm'),
            quickQuestionInput: document.getElementById('quickQuestionInput'),
            quickSubmitBtn: document.getElementById('quickSubmitBtn'),
            responseTime: document.getElementById('responseTime')
        };

        // Initialize Application
        document.addEventListener('DOMContentLoaded', function() {
            initializeApp();
        });

        function initializeApp() {
            initializeTheme();
            setupEventListeners();
            updateResponseTime();
            setupSuggestedQuestions();
            addAnswerAnimations();
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
            elements.copyBtn.addEventListener('click', copyToClipboard);
            elements.shareBtn.addEventListener('click', shareAnswer);
            elements.printBtn.addEventListener('click', printAnswer);
            elements.quickQuestionForm.addEventListener('submit', handleQuickQuestion);
        }

        // Copy to Clipboard
        function copyToClipboard() {
            const answerText = elements.answerContent.textContent;
            
            if (navigator.clipboard) {
                navigator.clipboard.writeText(answerText)
                    .then(() => {
                        showSuccess(MESSAGES.SUCCESS.COPIED);
                        animateCopySuccess();
                    })
                    .catch(() => {
                        fallbackCopyToClipboard(answerText);
                    });
            } else {
                fallbackCopyToClipboard(answerText);
            }
        }

        function fallbackCopyToClipboard(text) {
            const textArea = document.createElement('textarea');
            textArea.value = text;
            textArea.style.position = 'fixed';
            textArea.style.opacity = '0';
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            
            try {
                document.execCommand('copy');
                showSuccess(MESSAGES.SUCCESS.COPIED);
                animateCopySuccess();
            } catch (err) {
                showError(MESSAGES.ERROR.COPY_FAILED);
            }
            
            document.body.removeChild(textArea);
        }

        function animateCopySuccess() {
            elements.copyBtn.innerHTML = '<i class="fas fa-check"></i>';
            elements.copyBtn.style.background = 'var(--success-gradient)';
            elements.copyBtn.style.color = 'white';
            
            setTimeout(() => {
                elements.copyBtn.innerHTML = '<i class="fas fa-copy"></i>';
                elements.copyBtn.style.background = 'var(--bg-secondary)';
                elements.copyBtn.style.color = 'var(--text-secondary)';
            }, 2000);
        }

        // Share Answer
        function shareAnswer() {
            const answerText = elements.answerContent.textContent;
            const shareData = {
                title: 'AI Assistant Answer',
                text: answerText,
                url: window.location.href
            };

            if (navigator.share) {
                navigator.share(shareData)
                    .then(() => showSuccess(MESSAGES.SUCCESS.SHARED))
                    .catch(() => fallbackShare(answerText));
            } else {
                fallbackShare(answerText);
            }
        }

        function fallbackShare(text) {
            // Create a temporary share modal or copy to clipboard as fallback
            copyToClipboard();
            showInfo('Answer copied to clipboard for sharing!');
        }

        // Print Answer
        function printAnswer() {
            const printWindow = window.open('', '_blank');
            const answerText = elements.answerContent.innerHTML;
            
           printWindow.document.write(
                '<html>' +
                    '<head>' +
                        '<title>AI Assistant Answer</title>' +
                        '<style>' +
                            'body {' +
                                'font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, sans-serif;' +
                                'line-height: 1.6;' +
                                'max-width: 800px;' +
                                'margin: 0 auto;' +
                                'padding: 2rem;' +
                            '}' +
                            'h1 { color: #667eea; }' +
                            '.answer-content {' +
                                'font-size: 1.1rem;' +
                                'margin: 2rem 0;' +
                            '}' +
                            '.footer {' +
                                'margin-top: 2rem;' +
                                'padding-top: 1rem;' +
                                'border-top: 1px solid #eee;' +
                                'font-size: 0.9rem;' +
                                'color: #666;' +
                            '}' +
                        '</style>' +
                    '</head>' +
                    '<body>' +
                        '<h1>AI Assistant Answer</h1>' +
                        '<div class="answer-content">' + answerText + '</div>' +
                        '<div class="footer">' +
                            'Generated by AI Summarizer • ' + new Date().toLocaleDateString() +
                        '</div>' +
                    '</body>' +
                '</html>'
            );

            
            printWindow.document.close();
            printWindow.print();
        }

        // Quick Question Handling
        function handleQuickQuestion(event) {
            event.preventDefault();
            
            const question = elements.quickQuestionInput.value.trim();
            if (!question) {
                showError(MESSAGES.ERROR.EMPTY_QUESTION);
                return;
            }

            // Show loading state
            showQuickQuestionLoading(true);

            // Submit form
            const formData = new FormData(elements.quickQuestionForm);
            fetch('ask', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();
            })
            .then(html => {
                // Replace current page content with new response
                document.open();
                document.write(html);
                document.close();
            })
            .catch(error => {
                console.error('Quick question error:', error);
                showError(MESSAGES.ERROR.NETWORK);
                showQuickQuestionLoading(false);
            });
        }

        function showQuickQuestionLoading(show) {
            if (show) {
            elements.quickSubmitBtn.innerHTML = 
                '<div class="loading-dots">' +
                    '<div class="loading-dot"></div>' +
                    '<div class="loading-dot"></div>' +
                    '<div class="loading-dot"></div>' +
                '</div>' +
                '<span>Processing...</span>';

                elements.quickSubmitBtn.disabled = true;
            } else {
               elements.quickSubmitBtn.innerHTML = 
                '<i class="fas fa-paper-plane"></i>' +
                '<span>Ask</span>';

                elements.quickSubmitBtn.disabled = false;
            }
        }

        // Suggested Questions
        function setupSuggestedQuestions() {
            const style = document.createElement('style');
           style.textContent = 
                '.suggested-q-btn {' +
                    'background: var(--bg-secondary);' +
                    'border: 1px solid var(--border-color);' +
                    'border-radius: 20px;' +
                    'padding: 0.4rem 0.8rem;' +
                    'font-size: 0.8rem;' +
                    'cursor: pointer;' +
                    'transition: all 0.3s ease;' +
                    'color: var(--text-secondary);' +
                '}' +
                '.suggested-q-btn:hover {' +
                    'background: var(--primary-gradient);' +
                    'color: white;' +
                    'transform: translateY(-1px);' +
                '}';

            document.head.appendChild(style);

            // Add event listeners to suggested question buttons
            document.addEventListener('click', function(event) {
                if (event.target.classList.contains('suggested-q-btn')) {
                    const question = event.target.getAttribute('data-question');
                    elements.quickQuestionInput.value = question;
                    elements.quickQuestionInput.focus();
                }
            });
        }

        // Response Time Update
        function updateResponseTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            elements.responseTime.textContent = 'Generated at ' + timeString;
        }

        // Answer Animations
        function addAnswerAnimations() {
            // Add typing effect to answer content
            const content = elements.answerContent;
            if (content && content.textContent.trim()) {
                content.classList.add('success-flash');
            }
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
    </script>
</body>
</html>
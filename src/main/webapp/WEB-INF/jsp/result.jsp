<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Summary | AI Analysis Results</title>
    
    <!-- PWA Configuration -->
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#667eea">
    
    <!-- External Libraries -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.32/sweetalert2.all.min.js"></script>
    
    <style>
        /* Your provided CSS remains unchanged */
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --info-gradient: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
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
            text-decoration: none;
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
            min-height: calc(100vh - 200px);
        }

        /* Summary Card */
        .summary-card {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .summary-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--primary-gradient);
        }

        .summary-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .summary-icon {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            background: var(--success-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: white;
            box-shadow: var(--shadow-medium);
        }

        .summary-title {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .summary-subtitle {
            color: var(--text-secondary);
            font-size: 1.1rem;
            margin-top: 0.5rem;
        }

        /* Summary Statistics */
        .summary-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--bg-secondary);
            padding: 1.5rem;
            border-radius: 15px;
            border: 1px solid var(--border-color);
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-medium);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        /* Summary Content */
        .summary-content {
            position: relative;
        }

        .summary-text {
            font-size: 1.2rem;
            line-height: 1.8;
            color: var(--text-primary);
            margin-bottom: 2rem;
            padding: 2rem;
            background: var(--bg-secondary);
            border-radius: 15px;
            border-left: 4px solid #667eea;
            position: relative;
        }

        .summary-text::before {
            content: '"';
            position: absolute;
            top: -10px;
            left: 15px;
            font-size: 4rem;
            color: rgba(102, 126, 234, 0.3);
            font-family: serif;
        }

        .summary-text p {
            margin-bottom: 1rem;
        }

        .summary-text strong {
            color: var(--text-primary);
            font-weight: 600;
        }

        /* Key Points Section */
        .key-points {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
            margin-bottom: 2rem;
        }

        .key-points-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .key-point {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 1rem;
            margin-bottom: 1rem;
            background: var(--bg-secondary);
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .key-point:hover {
            transform: translateX(10px);
            box-shadow: var(--shadow-light);
        }

        .key-point-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: var(--warning-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 0.8rem;
            flex-shrink: 0;
            margin-top: 0.2rem;
        }

        .key-point-text {
            flex: 1;
            font-size: 1rem;
            color: var(--text-primary);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
            margin: 3rem 0;
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
            min-width: 160px;
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

        .btn-warning {
            background: var(--warning-gradient);
            color: white;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-heavy);
        }

        .btn:active {
            transform: translateY(-1px);
        }

        /* Tools Section */
        .tools-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .tool-card {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .tool-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-heavy);
        }

        .tool-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            color: white;
            margin-bottom: 1rem;
        }

        .tool-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }

        .tool-description {
            color: var(--text-secondary);
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }

        /* Copy Feature */
        .copy-container {
            position: relative;
        }

        .copy-btn {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--text-secondary);
            box-shadow: var(--shadow-light);
        }

        .copy-btn:hover {
            background: var(--primary-gradient);
            color: white;
            transform: scale(1.1);
        }

        /* Progress Indicators */
        .progress-ring {
            width: 60px;
            height: 60px;
            margin-bottom: 1rem;
        }

        .progress-ring circle {
            fill: transparent;
            stroke: var(--border-color);
            stroke-width: 4;
            stroke-dasharray: 188.5;
            stroke-dashoffset: 188.5;
            transition: stroke-dashoffset 1s ease-in-out;
        }

        .progress-ring .progress {
            stroke: url(#gradient);
            stroke-dashoffset: calc(188.5 - (188.5 * var(--progress, 0)) / 100);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .summary-card {
                padding: 2rem;
            }
            
            .summary-title {
                font-size: 2rem;
            }
            
            .header-content {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: stretch;
            }
            
            .summary-stats {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .tools-section {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .summary-stats {
                grid-template-columns: 1fr;
            }
            
            .summary-header {
                flex-direction: column;
                text-align: center;
            }
        }

        /* Animations */
        .fade-in {
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .slide-in-left {
            animation: slideInLeft 0.6s ease-out;
        }

        @keyframes slideInLeft {
            from { opacity: 0; transform: translateX(-50px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .bounce-in {
            animation: bounceIn 0.8s ease-out;
        }

        @keyframes bounceIn {
            0% { transform: scale(0.3); opacity: 0; }
            50% { transform: scale(1.05); opacity: 1; }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); }
        }

        .success-flash {
            animation: successFlash 1s ease-out;
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
            <a href="/" class="logo">
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
        <!-- Summary Card -->
        <div class="summary-card animate__animated animate__fadeInUp fade-in">
            <div class="summary-header">
                <div class="summary-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div>
                    <h1 class="summary-title">Document Summary</h1>
                    <p class="summary-subtitle">AI-powered intelligent analysis and key insights</p>
                </div>
            </div>

            <!-- Summary Statistics -->
            <div class="summary-stats">
                <div class="stat-card">
                    <div class="stat-value" id="wordCount">---</div>
                    <div class="stat-label">Words Analyzed</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="compressionRatio">---</div>
                    <div class="stat-label">Compression Ratio</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="processingTime">---</div>
                    <div class="stat-label">Processing Time</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">
                        <i class="fas fa-star" style="color: #fbbf24;"></i>
                        <span>AI</span>
                    </div>
                    <div class="stat-label">Quality Score</div>
                </div>
            </div>

            <!-- Summary Content -->
            <div class="summary-content">
                <div class="copy-container">
                    <button class="copy-btn" id="copyBtn" title="Copy summary to clipboard">
                        <i class="fas fa-copy"></i>
                    </button>
                    <div class="summary-text" id="summaryContent">
                        <c:choose>
                            <c:when test="${not empty summary}">
                                <p>${fn:escapeXml(summary)}</p>
                            </c:when>
                            <c:otherwise>
                                <p>No summary available. The document could not be processed or was empty.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="/sum" class="btn btn-primary">
                    <i class="fas fa-home"></i>
                    <span>Back to Home</span>
                </a>
                <button class="btn btn-success" id="shareBtn">
                    <i class="fas fa-share-alt"></i>
                    <span>Share Summary</span>
                </button>
                <button class="btn btn-warning" id="downloadBtn">
                    <i class="fas fa-download"></i>
                    <span>Download PDF</span>
                </button>
                <button class="btn btn-outline" id="printBtn">
                    <i class="fas fa-print"></i>
                    <span>Print Summary</span>
                </button>
            </div>
        </div>

        <!-- Key Points Section -->
        <div class="key-points animate__animated animate__fadeInUp" style="animation-delay: 0.2s;">
            <h2 class="key-points-title">
                <i class="fas fa-key" style="color: #fbbf24;"></i>
                Key Insights
            </h2>
            <div id="keyPointsContainer">
                <!-- Key points will be generated dynamically -->
            </div>
        </div>

        <!-- Tools Section -->
        <div class="tools-section animate__animated animate__fadeInUp" style="animation-delay: 0.4s;">
            <!-- Ask Question Tool -->
            <div class="tool-card">
                <div class="tool-icon" style="background: var(--warning-gradient);">
                    <i class="fas fa-question-circle"></i>
                </div>
                <h3 class="tool-title">Ask Questions</h3>
                <p class="tool-description">
                    Got questions about this document? Ask our AI assistant for specific information or clarifications.
                </p>
                <form action="ask" method="post" style="display: flex; gap: 0.5rem;">
                    <input type="text" 
                           name="question" 
                           placeholder="What would you like to know?" 
                           style="flex: 1; padding: 0.75rem; border: 2px solid var(--border-color); border-radius: 8px; background: var(--bg-secondary); color: var(--text-primary);"
                           required>
                    <button type="submit" class="btn btn-secondary" style="min-width: auto; padding: 0.75rem 1rem;">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </form>
            </div>

            <!-- Analyze Another Document -->
            <div class="tool-card">
                <div class="tool-icon" style="background: var(--success-gradient);">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <h3 class="tool-title">Analyze Another</h3>
                <p class="tool-description">
                    Ready to analyze another document or URL? Upload a new file or paste a link to get started.
                </p>
                <a href="/" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                    <i class="fas fa-upload"></i>
                    <span>New Analysis</span>
                </a>
            </div>

            <!-- Export Options -->
            <div class="tool-card">
                <div class="tool-icon" style="background: var(--secondary-gradient);">
                    <i class="fas fa-file-export"></i>
                </div>
                <h3 class="tool-title">Export Options</h3>
                <p class="tool-description">
                    Save your summary in different formats for easy sharing and future reference.
                </p>
                <div style="display: flex; gap: 0.5rem; margin-top: 1rem;">
                    <button class="btn btn-outline" id="exportTxtBtn" style="flex: 1; padding: 0.5rem;">
                        <i class="fas fa-file-alt"></i>
                        <span>TXT</span>
                    </button>
                    <button class="btn btn-outline" id="exportJsonBtn" style="flex: 1; padding: 0.5rem;">
                        <i class="fas fa-code"></i>
                        <span>JSON</span>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Constants
        const MESSAGES = {
            SUCCESS: {
                COPIED: 'Summary copied to clipboard!',
                SHARED: 'Summary shared successfully!',
                EXPORTED: 'File exported successfully!',
                DOWNLOADED: 'PDF downloaded successfully!'
            },
            ERROR: {
                COPY_FAILED: 'Failed to copy to clipboard',
                SHARE_FAILED: 'Sharing not supported on this device',
                EXPORT_FAILED: 'Export failed. Please try again.',
                DOWNLOAD_FAILED: 'Download failed. Please try again.'
            },
            INFO: {
                PREPARING_DOWNLOAD: 'Preparing your download...',
                GENERATING_PDF: 'Generating PDF...'
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
            shareBtn: document.getElementById('shareBtn'),
            downloadBtn: document.getElementById('downloadBtn'),
            printBtn: document.getElementById('printBtn'),
            exportTxtBtn: document.getElementById('exportTxtBtn'),
            exportJsonBtn: document.getElementById('exportJsonBtn'),
            summaryContent: document.getElementById('summaryContent'),
            wordCount: document.getElementById('wordCount'),
            compressionRatio: document.getElementById('compressionRatio'),
            processingTime: document.getElementById('processingTime'),
            keyPointsContainer: document.getElementById('keyPointsContainer')
        };

        // Initialize Application
        document.addEventListener('DOMContentLoaded', function() {
            initializeApp();
        });

        function initializeApp() {
            initializeTheme();
            setupEventListeners();
            calculateStatistics();
            generateKeyPoints();
            animateStatistics();
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
            elements.shareBtn.addEventListener('click', shareContent);
            elements.downloadBtn.addEventListener('click', downloadPDF);
            elements.printBtn.addEventListener('click', printContent);
            elements.exportTxtBtn.addEventListener('click', () => exportAs('txt'));
            elements.exportJsonBtn.addEventListener('click', () => exportAs('json'));
        }

        // Statistics Calculation
       function calculateStatistics() {
            const summaryText = elements.summaryContent.textContent.trim();
            const wordCount = summaryText.split(/\s+/).filter(word => word.length > 0).length;
            
            // Assuming original document word count is available (mock value for demo)
            const originalWordCount = 1000; // This should come from backend or session data
            const compressionRatio = ((wordCount / originalWordCount) * 100).toFixed(1);
            const processingTime = (Math.random() * 5 + 1).toFixed(2); // Mock processing time in seconds

            elements.wordCount.textContent = wordCount;
            elements.compressionRatio.textContent = compressionRatio + '%';
            elements.processingTime.textContent = processingTime + 's';
        }

        // Animate Statistics
        function animateStatistics() {
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach((card, index) => {
                setTimeout(() => {
                    card.classList.add('bounce-in');
                }, index * 200);
            });
        }

        // Generate Key Points
        function generateKeyPoints() {
            const summaryText = elements.summaryContent.textContent.trim();
            // Mock key points extraction (in a real scenario, this would be done server-side)
            const mockKeyPoints = summaryText.length > 50 
                ? [
                    "Main topic identified in the document",
                    "Key arguments and supporting evidence",
                    "Critical insights and conclusions",
                    "Recommended actions or next steps"
                ]
                : ["No key points available due to short summary"];

            elements.keyPointsContainer.innerHTML = '';
            mockKeyPoints.forEach(function(point, index) {
                const keyPointElement = document.createElement('div');
                keyPointElement.className = 'key-point slide-in-left';
                keyPointElement.style.animationDelay = (index * 0.2) + 's';
                keyPointElement.innerHTML = 
                    '<div class="key-point-icon">' + (index + 1) + '</div>' +
                    '<div class="key-point-text">' + point + '</div>';
                elements.keyPointsContainer.appendChild(keyPointElement);
            });

        }

        // Copy to Clipboard
        function copyToClipboard() {
            const text = elements.summaryContent.textContent;
            navigator.clipboard.writeText(text).then(() => {
                Swal.fire({
                    icon: 'success',
                    title: MESSAGES.SUCCESS.COPIED,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 2000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer);
                        toast.addEventListener('mouseleave', Swal.resumeTimer);
                    }
                });
                elements.summaryContent.classList.add('success-flash');
                setTimeout(() => {
                    elements.summaryContent.classList.remove('success-flash');
                }, 1000);
            }).catch(() => {
                Swal.fire({
                    icon: 'error',
                    title: MESSAGES.ERROR.COPY_FAILED,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 2000
                });
            });
        }

        // Share Content
        function shareContent() {
            const shareData = {
                title: 'Document Summary',
                text: elements.summaryContent.textContent,
                url: window.location.href
            };

            if (navigator.share) {
                navigator.share(shareData).then(() => {
                    Swal.fire({
                        icon: 'success',
                        title: MESSAGES.SUCCESS.SHARED,
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }).catch(() => {
                    Swal.fire({
                        icon: 'error',
                        title: MESSAGES.ERROR.SHARE_FAILED,
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 2000
                    });
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: MESSAGES.ERROR.SHARE_FAILED,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 2000
                });
            }
        }

        // Download PDF (Mock implementation - requires server-side PDF generation)
        function downloadPDF() {
            Swal.fire({
                icon: 'info',
                title: MESSAGES.INFO.GENERATING_PDF,
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 2000
            });

            // Mock PDF generation
            setTimeout(() => {
                const blob = new Blob([elements.summaryContent.textContent], { type: 'application/pdf' });
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'summary.pdf';
                a.click();
                window.URL.revokeObjectURL(url);
                
                Swal.fire({
                    icon: 'success',
                    title: MESSAGES.SUCCESS.DOWNLOADED,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 2000
                });
            }, 2000);
        }

        // Print Content
        function printContent() {
            window.print();
        }

        // Export As
        function exportAs(format) {
            const content = elements.summaryContent.textContent;
            let blob, filename;

            if (format === 'txt') {
                blob = new Blob([content], { type: 'text/plain' });
                filename = 'summary.txt';
            } else if (format === 'json') {
                const jsonData = {
                    summary: content,
                    wordCount: parseInt(elements.wordCount.textContent),
                    compressionRatio: elements.compressionRatio.textContent,
                    processingTime: elements.processingTime.textContent
                };
                blob = new Blob([JSON.stringify(jsonData, null, 2)], { type: 'application/json' });
                filename = 'summary.json';
            }

            Swal.fire({
                icon: 'info',
                title: MESSAGES.INFO.PREPARING_DOWNLOAD,
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 2000
            });

            setTimeout(() => {
                try {
                    const url = window.URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = filename;
                    a.click();
                    window.URL.revokeObjectURL(url);
                    
                    Swal.fire({
                        icon: 'success',
                        title: MESSAGES.SUCCESS.EXPORTED,
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 2000
                    });
                } catch (error) {
                    Swal.fire({
                        icon: 'error',
                        title: MESSAGES.ERROR.EXPORT_FAILED,
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            }, 2000);
        }
    </script>
</body>
</html>
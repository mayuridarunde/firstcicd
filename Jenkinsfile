pipeline {
    agent any

    stages {
        stage("Checkout Code") {
            steps {
                git url: 'https://github.com/mayuridarunde/firstcicd.git', branch: 'main'
            }
        }

        stage("Build Docker Image") {
            steps {
                bat 'docker build -t myimage .'
            }
        }

        stage("Clean Old Containers") {
            steps {
                echo "🧹 Cleaning up old containers (if any)..."
                bat '''
                @echo off
                for /F "tokens=*" %%i in ('docker ps -q --filter "ancestor=myimage"') do docker stop %%i >nul 2>&1
                for /F "tokens=*" %%i in ('docker ps -a -q --filter "ancestor=myimage"') do docker rm %%i >nul 2>&1
                exit /b 0
                '''
            }
        }

        stage("Run New Container") {
            steps {
                bat 'docker run -d -p 8501:8501 --name streamlit_app myimage'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully! Visit http://localhost:8501 to open your Streamlit app."
        }
        failure {
            echo "❌ Pipeline failed. Please check console logs for details."
        }
    }
}
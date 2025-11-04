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
                for /F "tokens=*" %%i in ('docker ps -q --filter "ancestor=myimage"') do docker stop %%i || exit 0
                for /F "tokens=*" %%i in ('docker ps -a -q --filter "ancestor=myimage"') do docker rm %%i || exit 0
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
        failure {
            echo "❌ Pipeline failed. Please check console logs for details."
        }
        success {
            echo "✅ Pipeline completed successfully! Access the app at http://localhost:8501"
        }
    }
}

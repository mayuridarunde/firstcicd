pipeline {
    agent any

    stages {
        stage("Checkout Code") {
            steps {
                echo "📥 Checking out source code..."
                git url: 'https://github.com/mayuridarunde/firstcicd.git', branch: 'main'
            }
        }

        stage("Build Docker Image") {
            steps {
                echo "🐳 Building Docker image..."
                bat 'docker build -t myimage .'
            }
        }

        stage("Clean Old Containers") {
            steps {
                echo "🧹 Cleaning up old containers (if any)..."
                // Stop and remove existing containers using the same image/port
                bat '''
                for /f "tokens=*" %%i in ('docker ps -q --filter "ancestor=myimage"') do docker stop %%i
                for /f "tokens=*" %%i in ('docker ps -a -q --filter "ancestor=myimage"') do docker rm %%i
                '''
            }
        }

        stage("Run New Container") {
            steps {
                echo "🚀 Starting new Streamlit container..."
                bat 'docker run -d -p 8501:8501 --name streamlit_app myimage'
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful! App available at http://localhost:8501"
        }
        failure {
            echo "❌ Pipeline failed. Please check console logs for details."
        }
    }
}


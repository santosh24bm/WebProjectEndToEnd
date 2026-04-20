# Spring Boot REST API - End to End Deployment

A complete Spring Boot REST API application with Docker containerization and cloud deployment ready.

## Project Structure

```
├── src/
│   └── main/
│       ├── java/com/example/
│       │   ├── Application.java
│       │   └── HelloController.java
│       └── resources/
│           └── application.properties
├── pom.xml
├── Dockerfile
└── README.md
```

## Running Locally

### Prerequisites

- Java 17+
- Maven 3.9+

### Start the Application

```bash
export PATH="/usr/local/maven/bin:/usr/local/java17/Contents/Home/bin:$PATH"
export JAVA_HOME="/usr/local/java17/Contents/Home"
cd /Users/santoshkumarmangasuli/Desktop/springboot-app
mvn spring-boot:run
```

The application will run on `http://localhost:8080`

## Docker

### Build Docker Image

```bash
docker build -t springboot-app:latest .
```

### Run Docker Container

```bash
docker run -p 8080:8080 springboot-app:latest
```

Access the application at `http://localhost:8080`

## API Endpoints

- `GET /` - Hello endpoint (if configured in HelloController)

## Deployment

### Google Cloud Run (Free Tier)

1. Push image to Google Container Registry:

```bash
docker tag springboot-app:latest gcr.io/PROJECT_ID/springboot-app:latest
docker push gcr.io/PROJECT_ID/springboot-app:latest
```

2. Deploy to Cloud Run:

```bash
gcloud run deploy springboot-app \
  --image gcr.io/PROJECT_ID/springboot-app:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## Environment Variables

- `JAVA_OPTS` - JVM options (default: `-server -Xmx512m -XX:+UseG1GC`)
- `server.port` - Server port (default: 8080)

## License

MIT

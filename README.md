# Networking_CA1
CI/CD Automation

# Sample Flask Application

This is a simple Flask app, which runs in a Docker container. The application listens on port 5000.

## Running Locally

To run the application locally, follow these steps:

1. Clone the repository.
2. Build the Docker image:
   bash
   docker build -t sample_app .
   
3. Run the Docker container:
   bash
   docker run -p 5000:5000 sample_app
   
4. Visit http://localhost:5000 in your browser.

## Deployment

This application is deployed to an EC2 instance using Azure DevOps pipelines.
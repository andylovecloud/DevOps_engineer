# Lab 4 - Build Nodejs Project 

**Part 1:** 
Requirements:
- Install and configure Nodejs for Jenkins server.
- Create a build project with the following steps:
- Checkout code from a sample Github repository (Vuejs+Webpack code).
- Run the build using the npm install + npm run build commands
    - Test build and check the results.
    - Check the created artifact.

**Part 2:**
Requirements:
- Add step to upload Artifact (dist folder) to an S3 bucket.
- Rebuild and check html, css, js uploaded to S3.
**Note**: Jenkins server must have IAM role required to upload to s3.
[Optional] Enable static web hosting for S3 to see if the build code works
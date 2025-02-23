# Lab 3 - Build Java Project 

part 1:
**Requirements**:
- Install and configure JDK for Jenkins server.
- Install and configure Maven for Jenkins server.
- Create a build project with the following steps:
    - Checkout code from a sample Github repository (Java code).
    - Run the build using Maven command.
- Test build and check the results.
- Check the created artifact.

part 2:

- Add step to upload Artifact (war/jar package) to an S3 bucket.
- Rebuild and check the war package uploaded to S3.

**Note**: Jenkins server must have the necessary IAM role to upload to s3.
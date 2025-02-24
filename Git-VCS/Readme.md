# Introduction
**Git** is a popular version control system (VCS) used to track changes in source code during software development. Git was developed by Linus Torvalds in 2005 and quickly became an important tool for developers.

**Git** helps development teams _work_ together _on the same project_ **without having to conflict** different versions of the source code. It helps **track** the history of **changes**, **manage branches** to develop multiple features or fixes simultaneously, and has the **ability to rollback** to previous versions of the project.

## Features of Git
- Open-source.
- Git architecture: Operating on a distributed model (Distributed), each developer will have a copy of the code base and can change/sync with each other. The distributed architecture also allows developers to work offline (no-internet).
- Works efficiently and quickly even with repositories with large codebases.
- Uses a content-addressable file system to save all versions of files in the repository for quick access and easy retrieval of old versions.
- Changes on Git will usually be adding new content. Even if you **revert** a change it will create an additional commit that means reverting, not completely deleting it.

## Git architecture
|                    |               |
|---------------     |-------------- |
|- **GitRepository**: where all code files, folders, project history are stored. The repository can be located on a local machine, server, or on the Cloud. <br> <br> - **Commit**: a snapshot of the codebase at a specific point in time.<br> <br> - **Branch**: a separate line created from a commit of the codebase. <br> <br> - **Merge**: combine a branch into another branch. <br> <br> - **Remote**: A copy of the repository located on another machine or server. Remotes can be used to collaborate with other developers and synchronize changes between different copies of the repository. <br><br> - **Clone**: ​​A copy of the repository. <br><br> - **Pull**: The act of downloading changes from a remote repository and merging them into the local repository.<br><br> - **Push**: The act of uploading changes from a local repository to a remote repository.|<img width="736" alt="Git-architecture" src="https://github.com/user-attachments/assets/3ea21182-eb4c-406a-8b37-7582fcb21718" />|


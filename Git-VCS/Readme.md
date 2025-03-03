# Introduction
[**Git**](https://git-scm.com/doc) is a popular version control system (VCS) used to track changes in source code during software development. Git was developed by Linus Torvalds in 2005 and quickly became an important tool for developers.

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

## Git life cycle
|                    |               |
|---------------     |-------------- |
|1. **Create**: Create a new repository on your local machine or on a remote server. <br><br> 2. **Modify**: add additional code files using IDEs. Git will automatically detect the changes. <br><br> 3. **Stage**: use the git add command to prepare changes to be committed to the repository. <br><br> 4. **Commit**: Apply changes to the repository. <br><br> 5. **Push**: push changes from the local repository to another repository (eg Github, corporate Git server). | <img width="608" alt="Git-life-cycle" src="https://github.com/user-attachments/assets/30c74260-5172-4869-9067-f2d2480e6e1a" />|

## Some Workflow models:
|                    |               |
|---------------     |-------------- |
|**Centralized workflow**: Suitable for small projects, simple codebase. Developer clones repository to local machine, makes changes then pushes back to central repository.<br> _**Disadvantage**_: easy to cause conflicts when many people edit the same module or file. | <img width="488" alt="Git-Centralized-worklife-models" src="https://github.com/user-attachments/assets/a8548db1-8e06-4c7e-82ff-90cd067f6d98" />|
|**Feature Branch workflow**: Whenever a developer develops a new feature, they will create a separate branch from the main branch. After finishing the work, they will create a pull-request to merge back. | <img width="736" alt="Git-feature-branch-workflow" src="https://github.com/user-attachments/assets/fe0f1bbe-7c84-4746-bee3-2ef7949151fe" />|
|**Gitflow workflow**: Suitable for large projects, complex codebases, with long development time. <br> This model divides branches into brancheswith different tasks such as: <br> **main:** the main branch maintained throughout the project's lifecycle. Code can only be merged into it when there is a major release or hot-fix. Tagged according to the release version. <br> - **develop**: the branch used by developers to develop feature/fix-bug. Code is checked out from here and merged back when the task is completed.<br> - **feature-***: naming rule depends on the project. eg feature-<ticket-id>. Checkout from the develop branch. <br> - **bugfix-***: similar to the feature branch, used to fix bugs. <br> - **release**: created before each new release version, code is usually deployed to the test/staging environment, can make minor edits (optional). <br> - [Git cheat sheet](https://training.github.com/downloads/github-git-cheat-sheet/)| <img width="808" alt="Gitflow-workflow" src="https://github.com/user-attachments/assets/43c3407f-ca61-48d0-bacc-cfe8bd326448" />|

## Gitflow workflow – Mapping between branches and deployment environments

- **Dev environment**: usually deployed automatically when a pull request is merged into the develop branch (CICD).
- **Test environment**: used for Integration Testing, usually released according to the version from the release branch.
- **Staging environment**: used for System Testing & UAT activities before releasing to end-users. Basically, the Staging mt must be the same as the Production environment.
- When applying Hotfix, it is recommended to test first with the Staging environment before applying merge to the main and deploying to Production.

<img width="743" alt="Gitflow-workflow-mapping-braches" src="https://github.com/user-attachments/assets/caa6ada7-c8df-427a-bde2-5bd3e72aed40" />

**_Note_**: _the above mapping rules are for reference only and can be completely customized depending on the project scale and customer requirements. However, breaking the standard deployment flow, applying too many hot-fixes, and releasing without testing will reduce the project quality and cost a lot of effort to fix._

## Some Git service providers:

<img width="1334" alt="Git-service-providers" src="https://github.com/user-attachments/assets/f7b8de41-04df-47a4-9416-e944923d606f" />

## Some basic operation
- **git version**: check your git version
- **git status**: check where are you working on
- **git branch --all / --a**: see all the branches.
- **git switch <BRANCH-NAME>**: to switch the branch you created.
- **git add <my-file>**: move the file from the working tree to the staging area
- **git commit**: take your snapshot
- **git log**: check the history of your activities.
- **git show <commit hash>**: displays information about the commit with the hash
- **git stash**: Temporarily save unfinished work to an area to switch to another branch.
  - git stash: This cmd only includes tracked files.
  - git stash --include-untracked: This cmd also includes untracked files.
  - git stash apply: take the stashed changes to the current branch.
- **git reset**: Reset the current branch.
  - git reset --hard <commit>: move the branch to the specified commit and discard all changes after that commit.
  - git reset --mixed <commit>: move the branch to the specified commit and make the changed files unstaged. You can review & add the necessary files.
  - git reset --soft <commit>: move the branch to the specified commit and keep the changed files staged. You can re-run the git commit command to commit again.

## Distinguish between Git Merge vs. Rebase vs Squash commit
When combining code between a feature branch and a main branch (e.g. develop), there are two commonly used approaches:
- **Merge**: create a new common node between the two branches.
- **Rebase**: Bring all commits from the source branch to the top of the target branch (in order).
- **Squash** commit: bring all commits from the source branch into a single commit and push it to the top of the target branch.

<img width="1291" alt="Distinguish between Git Merge vs  Rebase vs Squash commit" src="https://github.com/user-attachments/assets/99b62288-74b8-423c-b7c7-b0dbc77bcc9e" />


## Best practice for Git using
- **Use Branches**: Use branches whenever developing a feature or fixing a bug. Helps developers work without affecting each other, and also makes it easier to review changes.
- **Commit frequently**: Helps track progress, isolate changes, and easily revert if necessary. Each commit should include logic and small (atomic) changes.
- **Write clear, easy-to-understand commit messages**: Helps other members easily review code.
- **Pull Before Push**: Always pull the latest code from the remote repository before pushing changes. Helps reduce conflicts and ensures you're working with the latest code base.
- **Review Code**: Detect bugs early, improve code quality, share knowledge among team members.
- **Resolve Conflicts appropriately**: Take the time to understand the code content before resolving conflicts.
- **Use Git Tags and Releases**: Use git tags for important milestones. Helps track releases, manage stable versions, and simplify the deployment process.
- **Backup and Remote Repositories**: Regularly backup remote repository to avoid data loss.

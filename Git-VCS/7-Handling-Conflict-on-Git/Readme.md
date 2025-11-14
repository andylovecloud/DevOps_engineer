# Lab7 – Handling conflicts on Git.
Simulate a situation where 2 developers Dev-A and Dev-B edit a function, leading to a conflict between the
developer and the person who created the Pull Request.

• The repo has a develop branch containing the file test.txt.

• Developer A checkouts the new branch feature/devA and edits test.txt. Then adds the file
test.txt and commits.

• Developer B checkouts the new branch feature/devB and edits test.txt. Then adds the file a.txt
and commits. And finally merges it into develop without conflict.

• Person A now merges it into develop, but develop now contains the content of
devB, not the content of develop at checkout -> conflict.

• Resolve the conflict and then recreate the pull request.


----------------
**Summary:**
- Hạn chế conflict trong quá trình làm việc chung:
- Hạn chế code chung module.
- Luôn pull latest code trước khi thay đổi.
📘 Introduction

This document outlines the process for creating, organizing, and executing test cases using Zephyr in Jira.

**Purpose**: Standardize test case management.
**Scope**: Applies to all QA members involved in manual or automated testing.

Detail instruction can be foud via the file [Test-Case-Management](https://github.com/andylovecloud/DevOps_engineer/blob/main/Test-Case-Management/PT-Test%20Case%20Management-141125-101925.pdf))

✅ Pre-requisites

Jira access with Zephyr plugin installed
(Find it under Apps → Search “Zephyr”)

Proper permissions to create/execute test cases

Familiarity with Jira issue types and workflows

🧭 Navigation Overview

From any Jira project:

Go to Zephyr in the left sidebar.

You will see four main tabs:

Tab	Purpose
Test Cases	Create & manage test cases
Test Cycles	Create and manage execution cycles
Test Plans	Organize test cycles for releases
Reports	View testing metrics & results

Tip: Check project permissions under
Project Settings → Apps → Zephyr

📂 1. Folder Structure for Test Cases

Go to Test Cases

Click + New Folder

Create a high-level structure per application
Example:

Teamcenter
├── Smoke Test Cases
├── Regression Test Cases
├── Integration Test Cases
└── Unit Test Cases


Create subfolders using the … menu next to the folder

📝 2. Creating Test Cases

Select the folder where the test case belongs

Click + New Test Case

Fill in metadata:

Field	Description
Name	Clear descriptive title
Objective	Purpose of the test
Preconditions	Setup prior execution
Priority	Based on impact
Components	Product/module name
Folder	Default selected folder
Labels	Tagging

Click Create and Edit

Under Test Script, choose Add Steps Manually

Adding Steps

Each step includes:

Step – instruction

Test Data

Expected Result

Use + Add Step to continue adding steps.

⚙️ 3. Features in Test Case Steps
3.1 Add Step

Add a new test step below the current one.

3.2 Call to Test

Reuse an existing test case inside another test case.
Useful for modular test design.

3.3 Hide/Show Steps

Appears when using Call to Test—allows collapsing referenced steps.

3.4 Add Parameter

Allows parameterized execution.

Example:

Enter application URL as {Url}


Process:

Select Data Type: Parameter

Add parameter name + default value

Use { to insert parameters

Edit parameter set at the top panel

🔄 4. Version Control

When requirements change, use version control:

Click + beside the version number (e.g., Version 1.0)

Confirm creation of a new version

Modify the test case

Save changes under the new version

Choose appropriate version during execution

🧪 5. BDD Test Cases (Informational)

Though not currently used:

Use BDD-Gherkin under Test Script

Format follows Given – When – Then

Can export via More → Export feature files (BDD-Gherkin)

🔢 6. Data-Driven Test Cases

Allows executing the same test steps with multiple data sets.

Steps:

Under Test Script, choose Test Data

Add columns for test data

Add rows for data sets

Use {ColumnName} inside steps or test data fields

🚀 7. Test Cycle / Test Execution
7.1 Folder Structure for Cycles

Similar to test cases:

Teamcenter
└── Release 1.0
    ├── Sprint 1
    ├── Sprint 2
    └── Hotfix

7.2 Creating a Test Cycle

Navigate to Test Cycles

Select folder

Click + New Test Cycle

Fill metadata:

Name

Description

Release Version

Iteration

Owner

Planned Start/End Date

Folder Location

Click Create and Edit

7.3 Add Test Cases to a Cycle

Click Add Test Cases

Select folder(s)

Choose test cases

Use Add others to combine multiple folders

Click Add

7.4 Clone a Test Cycle

Select a cycle

Click Clone

Edit fields and folder location to reuse cycle for new release/sprint

7.5 Execute Test Cases

Go to the test cycle

Assign:

Environment

Tester

Release version

Click Play icon to begin execution

Update each step’s result:

Pass

Fail

Blocked

Skipped

In Progress

If a step fails →

Create New Issue or

Add Existing Issue

Progress updates automatically.

📊 8. Reporting & Metrics

Use Test Execution Reports for:

Pass/Fail rates

Defect density

Requirement coverage

Execution progress

🔁 9. Maintenance

Review and update test cases regularly

Maintain traceability to Jira requirements and defects

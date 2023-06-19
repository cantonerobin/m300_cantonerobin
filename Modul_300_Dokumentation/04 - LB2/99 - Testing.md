# Github Action
| Test No. | Initial State | Input | Expected Output | Actual Output | Pass/Fail |
|----------|---------------|-------|-----------------|---------------|-----------|
|   1       |  The main branch exists with the Dockerfile and Github Action configured            |   Code gets pushed to the main branch     |        GitHub Action starts to run         |       GitHub Action runs        |     Pass      |
|   2       |    The main branch exists with the Dockerfile and Github Action configured           |  Code gets pushed to the main branch     |     Github action runs, builds and pushes the Image to the DockerHub registry            |   Github action runs, builds and pushes the Image to the DockerHub registry            |      Pass     |
|   3       |               |       |                 |               |           |

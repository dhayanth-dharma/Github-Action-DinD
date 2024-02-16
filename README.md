# action-runners
GitHub Action self hosted runners based on DinD method


# Attention !!! DinD will give root access to the containers. Use Sysbox for better security.

## Steps to run:
1. Add github repository secrets to copy the files to remote server (AWS, GC, Azure etc)
 - ACCESS_TOKEN : Github personal access token
 - REPO : Repo name (Eg: TestOrg/TestRepo)
 - SSH_PRIVATE_KEY: Private key for connect to remote server via ssh
 - RUNNER_VPS_PORT: SSH port
 - RUNNER_VPS_USER: SSH User (Should not be root and with sudo previlege)
 - RUNNER_VPS_HOST: Remote server IP
 - SLACK_WEBHOOK: If you need slack message notification after completion

2. Run the action (deploy-runner)
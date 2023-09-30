# Terraform Beginner Bootcamp 2023


## WEEK O:
Here is an overview of what was discussed in week zero of the bootcamp

### GITHUB SEMANTIC VERSIONING
Given a version number MAJOR.MINOR.PATCH, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

- Typically, on GitHub, an [issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/about-issues) is created for either a bug fix or the addition of a feature to a software project. 
- Once the issue has been created, the issue's name is used to create a feature branch from Github GUI or by using the below command
    ```git
    git checkout -b (branchname)
    ```
- After developing the code in the feature branch, we commit and push it to the remote repository. Then, we proceed to create a pull request to merge the feature branch into the main branch.
- Once the pull request is accepted, a tag is created to preserve the project's state.

To learn more about Semantic Versioning, branching and tags, you can find useful documentation on this topic below
- [CircleCI.](https://circleci.com/blog/git-tags-vs-branches/)
- [Semantic Versioning.](https://semver.org/)

Additionally, if you **encounter problems when pushing your commit to a remote repository due to permissions, please review your [Gitpod permissions](https://www.gitpod.io/docs/configure/authentication/github)**

## TERRAFORM CLI INSTALLATION ON GITPOD USING BASH
The Terraform CLI installation in the gitpod.yml file is broken due to gpg keyring changes. To address this issue, we refactored the script following the steps below:

- Create an issue in Github to document the problem.
- Create a feature branch in Github based on the created issue.
- Check the version of linux distribution that is deployed in Gitpod
- Check out the feature branch.
- Create a new "bin" folder and a Bash file.
- Copy the Terraform installation commands into the Bash file. Make sure to include the shebang and set the necessary file permissions.
- Modify the Gitpod task from "init" to "before" to ensure that the installation script runs at startup.
- Test the changes and confirm it works.
- Create a commit from the feature branch tagging the issue number
- Create a pull request from the feature branch to main
- Once the pull request is accepted, checkout to the main branch, git pull to get the latest updates and then create a tag to preserve the project's state.
 
Installing terraform can be found on the [terraform website](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). The installation steps periodically change so it is best to check from time to time in order to stay updated.

Here are resources that help in understanding this exercise. 
- [Linux distribution](https://www.linux.com/training-tutorials/how-find-your-linux-version-or-distro-release-and-why-it-matters/)
- [Linux bash scripting](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-writing-a-simple-bash-script)
- [Linux file permissions](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-understanding-linux-file-permissions)
- [Gitpod task documentation](https://www.gitpod.io/docs/configure/workspaces/tasks)

## PROJECT ROOT ENVIRONMENT
We examined several methods for setting environment variables: one using a Bash script and the other using the Gitpod method with a .env file.

Environment variables store information about the environment in which a process runs, and they can be accessed and manipulated within Bash scripts.


**Defining Environment Variables**:
   - You can define environment variables in your Bash script using the `export` command or by simply assigning a value to a variable name without the `export` keyword.
   - For example:
     ```bash
     export MY_VARIABLE="Hello, Terraformers!"
     MY_OTHER_VARIABLE="2023"
     ```
 **Accessing Environment Variables**:
   - To access the value of an environment variable, you can use the `$` symbol followed by the variable name.
   - For example:
     ```bash
     echo $MY_VARIABLE
     ```
- We can list all the environment variables by using
    ```
    env
    ```
- We can filter for specific env variables by using *grep*. For example
    ```
    env | grep PRJOECT_ROOT
    ```
 **System Environment Variables**:
   - Linux also has a set of system-wide environment variables that store crucial system information. These can be accessed and utilized in your scripts as well.
   - Common system environment variables include `$PATH` (containing directories for executable files), `$HOME` (the user's home directory), and many others.

 **Removing Environment Variables**:
   - To remove an environment variable, you can use the `unset` command.
   - For example:
     ```bash
     unset MY_VARIABLE
     ```
**System Environment Variables**:
- You can set environment variables for a Gitpod task terminal using various methods.
- By setting the env property within the task definition in your .gitpod.yml. Please note that such environment variables will be limited to the task terminal and are not globally set across the workspace.
- Visit [Gitpod documentation](https://www.gitpod.io/docs/configure/projects/environment-variables) for more information on how to set environment variables in Gitpod.

**Scoping of Env vars**:

When you open a new Bash terminal in VSCode, it will not be aware of environment variables set in another window. If you want the environment variable to persist across all future Bash terminals that are opened, you need to set the environment variable in your Bash profile, for example, in the `.bash-profile file`.
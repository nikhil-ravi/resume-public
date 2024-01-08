# Resume

Welcome to the public version of my resume repository! This repository is a stripped-down, privacy-conscious version of my resume, where sensitive information such as phone numbers and email addresses has been removed. It's designed for sharing with a broader audience without disclosing personal contact details.

## Accessing the Resume

> [!IMPORTANT] 
>  The `resume.md` file in this public repository is provided as a template and is not regularly updated. If you are interested in the most recent version of my resume, please refer to the [latest releases](https://github.com/nikhil-ravi/resume-public/releases/latest), where the public resume is available in both PDF and DOCX formats for easy accessibility. The releases contain up-to-date information and are intended for accurate representation.

## How it Differs from the Private Repository

The public repository serves as a more accessible version of my resume. It omits personal contact information to respect privacy concerns. If you need to contact me or access the complete resume, please contact me on [LinkedIn](https://www.linkedin.com/in/nikhil--ravi/).


## Usage

For those interested in implementing a similar workflow—maintaining both a private resume with complete information and a public resume with sensitive details removed—follow these steps:

### Local development
1. Fork this repository and clone it to your local machine.

2. Install the necessary dependencies (on Ubuntu):
  ```bash
  apt-get update
  apt-get install -y git make wget texlive-xetex
  ```
  Install Pandoc using the latest version available at [jgm/pandoc](https://github.com/jgm/pandoc/releases). Replace the version number in the commands below:
  ```bash
  wget https://github.com/jgm/pandoc/releases/download/3.1.11.1/pandoc-3.1.11.1-1-amd64.deb
  dpkg -i pandoc-3.1.11.1-1-amd64.deb
  rm pandoc-3.1.11.1-1-amd64.deb # remove the downloaded file
  ```
  Make sure to replace the version number in the above commands with the latest version of pandoc.  
  
3. Edit the `resume.md` file to your liking. To hide information in the public release, enclose that part of the text in HTML `span` tags with a class name of `privatize`:
  ```md
  # Nikhil Ravi
  
  New York, NY | <span class="privatize">1 (800) 800 8009 |</span> LinkedIn | GitHub
  ```
4. Run t:
  ```bash
  make all BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD) PRIVATIZE=true
  ```
  - The BRANCH_NAME variable is used to name the output files.
  - The PRIVATIZE variable, when set to true, removes the information enclosed in the `span` tags with the `privatize` class name, generating the public version of the resume.
5. This will create the PDF and DOCX files in the `output` directory.     
6. Once done editing, create two repositories, one private and the other public. 
7. Enable GitHub Actions in the private repository and provide `Read and Write` permissions to GitHub workflows under Repository `Settings > Actions > General > Workflow permissions`.  
8. Create a Fine-grained Personal Access Token under `Settings > Developer Settings > Personal access tokens > Fine-grained tokens` with access to both repositories. Enable `Read and Write` permissions for `Actions` and `Contents`.  
9. Add this token as a repository secret for the private repository under `Secrets and variables > Actions > Repository Secrets` with the name `RELEASE_REPO_SECRET`.  
10. Add the URL of the public repository as an environment variable under `Secrets and variables > Actions > Repository Variables` with the name `PUBLIC_REPO_URL`.  
11. Commit and push your changes to the private repository. This will start the workflow in `.github/workflows/build-resume.yml`, and release the private and public resumes on their respective repositories.  

### Auto compile on save with VS Code

Auto-compile `resume.md` to pdf and docx formats on save using the [Run on Save](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave) extension in VS Code. To use this feature, simply install the extension in VS Code. Then, enable the extension via the VS Code command palette (`Ctrl+Shift+P` or `Cmd+Shift+P`) using the following command:
```
Run on Save: Enable
```
Then, the [`.vscode/settings.json`](/.vscode/settings.json) file will be automatically loaded and the `resume.md` file will be compiled to pdf and docx formats on save.

### Docker Image

> [!IMPORTANT]  
> You don't need to do this! You can just use the same docker container. 

It was taking too long to setup `texlive-xetex` and `pandoc` in the GitHub Actions environment, so I created a Docker image with all the dependencies installed. It is available at [Docker Hub](https://hub.docker.com/r/muggle7/resume). 

To update the image, edit the [`Dockerfile`](/Dockerfile) and run the following command to build the image:

```bash
docker compose build resume
```
Then push the image to Docker Hub:

```bash
docker compose push resume
```

## Acknowledgements

I used dunkbing's [resume](https://github.com/dunkbing/dunkbing) as a starting point for this project after seeing it on [Dev.to](https://dev.to/dunkbing/managing-my-resume-with-git-a-version-control-approach-7hk).

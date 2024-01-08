# Resume

Welcome to the public version of my resume repository! This repository is a stripped-down, privacy-conscious version of my resume, where sensitive information such as phone numbers and email addresses has been removed. It's designed for sharing with a broader audience without disclosing personal contact details.

## Accessing the Resume

The public resume is available in both PDF and DOCX formats for easy accessibility. You can find the latest releases [here](https://github.com/nikhil-ravi/resume-public/releases/latest). Feel free to download and review the document.

## How it Differs from the Private Repository

The public repository serves as a more accessible version of my resume. It omits personal contact information to respect privacy concerns. If you need to contact me or access the complete resume, please contact me on [LinkedIn](https://www.linkedin.com/in/nikhil--ravi/).


## Usage

For those who would like to implement a similar workflow, i.e., a private resume with all the information written completely in Markdown and exported to both PDF and DOCX formats using pandoc, and a public resume with information marked as private removed, then the contents of this repository should get you there. 

### Local development

1. On Ubuntu, first install the dependencies (might need sudo):
  ```bash
  apt-get update
  apt-get install -y git make wget texlive-xetex
  ```
  We also need to install pandoc. The latest version of pandoc is available at [jgm/pandoc](https://github.com/jgm/pandoc/releases). To install the latest version of pandoc, run the following commands:
  ```bash
  wget https://github.com/jgm/pandoc/releases/download/3.1.11.1/pandoc-3.1.11.1-1-amd64.deb
  dpkg -i pandoc-3.1.11.1-1-amd64.deb
  rm pandoc-3.1.11.1-1-amd64.deb # remove the downloaded file
  ```
  Make sure to replace the version number in the above commands with the latest version of pandoc.  
  
2. Edit the `resume.md` file to your liking. If you want to hide something in the public release, simply enclose that part of the text in HTML `span` tags with a class name of `privatize`:
  ```md
  # Nikhil Ravi
  
  New York, NY | <span class="privatize">1 (800) 800 8009 |</span> LinkedIn | GitHub
  ```
3. Then run:
  ```bash
  make all BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD) PRIVATIZE=true
  ```
  - The BRANCH_NAME variable is used to name the output files.
  - The PRIVATIZE variable is used to determine whether to include the phone number and email address in the output files.
      - Set PRIVATE to true to remove the phone number and email address and generate the public version of the resume.
      - Set PRIVATE to false to include the phone number and email address and generate the private version of the resume.  
  This will create the PDF and DOCX files in the `output` directory.   
  
4. Once you are done editing, create two repositories, one private and the other public.  
5. Provide `Read and Write` permissions to GitHub workflows under `Repository Settings > Actions > General > Workflow permissions`.  
6. Create a Fine grained Personal Access Token under `Settings > Developer Settings > Personal access tokens > Fine-grained tokens` and provide it access to both the repositories and enable Read and Write permissions for `Actions` and `Contents`.  
7. Add this token as a repository secret for the private repository under `Secrets and variables > Actions > Repository Secrets` and give it the name `RELEASE_REPO_SECRET`.  
8. Add the url of the public repository as an environment variable unde `Secrets and variables > Actions > Repository Variables` and give it the name `PUBLIC_REPO_URL`.  
9. Commit and push your changes to your private repository. This will start the workflow in `.github/workflows/build-resume.yml`, and release the private and public resumes on their respective repositories.  

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


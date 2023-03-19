# GitHub_Automation_Module
Module requiered for retreiving information regarding github organisations and codespaces to automate the process in Jira, Ansible and Jenkins


# GitHub Automation Moduele for Intergration with Jira, Jenkins and Anisible
Working with Automation becomes much more easier when you have wide range of team size and compatibility in Organisations.
---
The Current Version of Bash Script contains the GitHub Automation required for Organisations to keep the track of Codespaces and code intergratibility to other Platforms.




# Executables

#### GITHUB_ACCESS_TOKEN
Ensure you provide permissions to access the GitHub Rest APIs while generating the token.


| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `access_token` | `string` | **Required**. Your Access token key |

```
export PASSWORD=<GITHUB_ACCESS_TOKEN>
echo $PASSWORD
```

#### GITHUB_API_HEADER


| Parameter | Value     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `GITHUB_API_HEADER`      | `application/vnd.github.v3+json` | **Required**. Response Header | |

```
./github_token_integration.sh $PASSWORD <GITHUB_RESTAPI>
```

## GitHub API Documenation

[Find More on GitHub API Docs](https://docs.github.com/en/rest)

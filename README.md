# elmah.io Upload Source Map

This extension is able to upload a source map and a minified JavaScript file to [elmah.io](https://elmah.io). When uploading a source map, bundled and minified stack traces will be readable on elmah.io.

## Usage

Go to the [elmah.io Upload Source Map](https://marketplace.visualstudio.com/items?itemName=elmahio.elmah-io-upload-source-map) extension on the Azure DevOps Marketplace and click the _Get it free_ button:

![Install the extension](images/marketplace_get_it_free.png)

Select your organization and click the *Install* button:

![Select organization](images/marketplace_select_organization.png)

The task supports both Pipelines and Releases. No matter which approach you choose, you will need to replace `API_KEY` with an API key ([Where is my API key?](https://docs.elmah.io/where-is-my-api-key/)) with permission ([How to configure API key permissions](https://docs.elmah.io/how-to-configure-api-key-permissions/)) to upload source maps. Replace `LOG_ID` with the ID ([Where is my log ID?](https://docs.elmah.io/where-is-my-log-id/)) of the log the source map belongs to. **Path** must contain the relative path to the minified JavaScript. **Source Map File** and **Minified JavaScript File** must contain a path to the generated source map and minified JavaScript file.

### Pipelines

Go to your Azure DevOps Pipeline configuration and add the *elmah.io Upload Source Map* task. Fill in the fields as shown here:

![Add the task](images/pipeline_task.png)

When clicking the *Add* button, YAML code will be added to your configuration looking similar to this:

```yaml
- task: ElmahIoUploadSourceMap@4
  inputs:
    apiKey: 'API_KEY'
    logId: 'LOG_ID'
    path: '/bundles/sharedbundle.min.js'
    sourceMap: '$(System.DefaultWorkingDirectory)/myproject/drop/bundles/sharedbundle.map'
    minifiedJavaScript: '$(System.DefaultWorkingDirectory)/myproject/drop/bundles/sharedbundle.min.js'
```

### Releases

Go to your Azure DevOps Release configuration and add the *elmah.io Upload Source Map* task. Fill in all fields as shown here:

![Add the task](images/release_pipeline_task.png)
import .data

apiVersion = "scaffolder.backstage.io/v1beta3"
kind = "Template"
metadata = {
    name = "crossplane-kubernetes"
    title = "Crossplane Kubernetes"
    description = "Create and Manage Kubernetes Clusters"
}
spec = {
    owner = "vfarcic/crossplane-kubernetes"
    type = "service"
    parameters = [{
        title = "Service Definition"
#       required:
#         - name
        properties = {
            name.type = "string"
            version.type = "string"
            nodeSize = {
                type = "string"
                enum = ["small", "medium", "large"]
            }
            minNodeCount = {
                type = "integer"
                default = 1
            }
#         public:
#           type: string
#           default: "true"
#           enum: ["true", "false"]
#         registry:
#           type: string
#           default: ttl.sh
#         app:
#           type: object
#           properties:
#             language:
#               type: string
#               default: go
#               enum: ["go", "js"]
#             host:
#               type: string
#               default: my-repo.acme.com
#             namespace:
#               type: string
#               default: a-team
#         db:
#           type: object
#           properties:
#             enabled:
#               type: string
#               default: "true"
#               enum: ["true", "false"]
#             provider:
#               type: string
#               default: aws
#               enum: ["aws", "azure", "google"]
#             version:
#               type: string
#               default: "16.2"
#         repo:
#           type: object
#           properties:
#             user:
#               type: string
#               default: vfarcic
#         gitops:
#           type: object
#           properties:
#             enabled:
#               type: string
#               default: "true"
#               pattern: '^(true|false)*$'
#             user:
#               type: string
#               default: vfarcic
#             repo:
#               type: string
#               default: crossplane-gh
        }
    }]
#   steps:
#     - id: log-message
#       name: Log Message
#       action: debug:log
#       input:
#         message: 'Hello, ${{ parameters.gitops.user }}/${{ parameters.gitops.repo }}!'
#     - id: fetch-template
#       action: fetch:template
#       name: Generate manifest
#       input:
#         url: ./backstage-templates
#         targetPath: ./git-repos
#         values:
#           name: ${{ parameters.name }}
#           public: ${{ parameters.public }}
#           registry: ${{ parameters.registry }}
#           app:
#             language: ${{ parameters.app.language }}
#             host: ${{ parameters.app.host }}
#             namespace: ${{ parameters.app.namespace }}
#           db:
#             enabled: ${{ parameters.db.enabled }}
#             provider: ${{ parameters.db.provider }}
#             version: ${{ parameters.db.version }}
#           repo:
#             user: ${{ parameters.repo.user }}
#           gitops:
#             enabled: ${{ parameters.gitops.enabled }}
#             user: ${{ parameters.gitops.user }}
#             repo: ${{ parameters.gitops.repo }}
#     - id: rename-manifest
#       action: fs:rename
#       name: Rename files
#       input:
#         files:
#           - from: ./git-repos/manifest.yaml
#             to: ./git-repos/${{ parameters.name }}.yaml
#     - id: create-pull-request
#       action: publish:github:pull-request
#       name: Create a pull request
#       input:
#         repoUrl: github.com?repo=${{ parameters.gitops.repo }}&owner=${{ parameters.gitops.user }}
#         branchName: init-${{ parameters.name }}
#         title: "Init: ${{ parameters.name }} app manifest [skip ci]"
#         description: This pull request creates or updates the ${{ parameters.name }} app manifest [skip ci]
}

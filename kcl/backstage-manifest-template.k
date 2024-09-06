import .data

# _properties = lambda title: str, properties: any -> any {
#     {
#         key = {
#             title = title + " " + key
#             type = value["type"]
#             enum = value["enum"]
#             if "defaultArray" in value:
#                 default = value["defaultArray"].rsplit(",", -1)
#             else:
#                 default = value["default"]
#             if "itemsType" in value:
#                 items.type = value["itemsType"]
#         } for key, value in properties
#     }
# }

# apiVersion = "scaffolder.backstage.io/v1beta3"
# kind = "Template"
# metadata = {
#     name = "crossplane-kubernetes"
#     title = "Crossplane Kubernetes"
#     description = "Create and Manage Kubernetes Clusters"
# }
# spec = {
#     owner = "vfarcic/crossplane-kubernetes"
#     type = "service"
#     parameters = [{
#         title = "Service Selector"
#         properties = {
#             name = {
#                 type = "string"
#                 "ui:autofocus" = True
#             }
#             provider = {
#                 type = "string"
#                 enum = ["aws", "azure", "google"]
#                 default = "aws"
#             }
#             namespace.type = "string"
#             repository.type = "string"
#             repositoryUser = {
#                 type = "string"
#                 default = "vfarcic"
#             }
#         }
#         required = ["name", "provider", "namespace", "repository"]
#     }, {
#         title = "Service Definition"
#         properties = _properties("General", data.root.properties)
#         required = data.root.required
#     }, {
#         title = "Apps"
#         properties.crossplane = {
#             type = "object"
#             properties = _properties("Crossplane", data.appCrossplane.properties)
#             required = data.appCrossplane.required
#         }
#         properties.argocd = {
#             type = "object"
#             properties = _properties("Argo CD", data.appArgocd.properties)
#             required = data.appArgocd.required
#         }
#         properties.openfunction = {
#             type = "object"
#             properties = _properties("OpenFunction", data.appOpenfunction.properties)
#             required = data.appOpenfunction.required
#         }
#         properties.dapr = {
#             type = "object"
#             properties = _properties("Dapr", data.appDapr.properties)
#             required = data.appDapr.required
#         }
#         properties.traefik = {
#             type = "object"
#             properties = _properties("Traefik", data.appTraefik.properties)
#             required = data.appTraefik.required
#         }
#     }]
#     steps = [{
#         id = "log-message"
#         name = "Log Message"
#         action = "debug:log"
#         input.message = "Created the manifest for the $[[ parameters.name ]] Kubernetes cluster.".replace("[[", "{{").replace("]]", "}}")
#     }, {
#         id = "fetch-template"
#         action = "fetch:template"
#         name = "Generate manifest"
#         input = {
#             url = "manifest-templates"
#             targetPath = "manifests"
#             values = {
#                 name = "$[[ parameters.name ]]".replace("[[", "{{").replace("]]", "}}")
#                 namespace =  "$[[ parameters.namespace ]]".replace("[[", "{{").replace("]]", "}}")
#                 provider =  "$[[ parameters.provider ]]".replace("[[", "{{").replace("]]", "}}")
#                 version =  "$[[ parameters.version ]]".replace("[[", "{{").replace("]]", "}}")
#                 nodeSize =  "$[[ parameters.nodeSize ]]".replace("[[", "{{").replace("]]", "}}")
#                 minNodeCount =  "$[[ parameters.minNodeCount ]]".replace("[[", "{{").replace("]]", "}}")
#                 namespaces = "$[[ parameters.namespaces ]]".replace("[[", "{{").replace("]]", "}}")
#                 crossplane.enabled = "$[[ parameters.crossplane.enabled ]]".replace("[[", "{{").replace("]]", "}}")
#                 argocd = {
#                     enabled = "$[[ parameters.argocd.enabled ]]".replace("[[", "{{").replace("]]", "}}")
#                     host = "$[[ parameters.argocd.host ]]".replace("[[", "{{").replace("]]", "}}")
#                     repoURL = "$[[ parameters.argocd.repoURL ]]".replace("[[", "{{").replace("]]", "}}")
#                     destinationNamespace = "$[[ parameters.argocd.destinationNamespace ]]".replace("[[", "{{").replace("]]", "}}")
#                     sourcePath = "$[[ parameters.argocd.sourcePath ]]".replace("[[", "{{").replace("]]", "}}")
#                 }
#                 openfunction.enabled = "$[[ parameters.openfunction.enabled ]]".replace("[[", "{{").replace("]]", "}}")
#                 dapr.enabled = "$[[ parameters.dapr.enabled ]]".replace("[[", "{{").replace("]]", "}}")
#                 traefik.enabled = "$[[ parameters.openfunction.enabled ]]".replace("[[", "{{").replace("]]", "}}")
#             }
#         }
#     }, {
#         id = "rename-manifest"
#         action = "fs:rename"
#         name = "Rename files"
#         input.files = [{
#             from = "manifests/cluster-claim.yaml"
#             to = "manifests/cluster-claim-$[[ parameters.name ]].yaml".replace("[[", "{{").replace("]]", "}}")
#         }]
#     }, {
#         # sourcePath: myrepo
#         # targetPath: '.'
#         id = "create-pull-request"
#         action = "publish:github:pull-request"
#         name = "Create a pull request"
#         input = {
#             repoUrl = "github.com?repo=$[[ parameters.repository ]]&owner=$[[ parameters.repositoryUser ]]".replace("[[", "{{").replace("]]", "}}")
#             branchName = "cluster-$[[ parameters.name ]]".replace("[[", "{{").replace("]]", "}}")
#             gitCommitMessage = "Kubernetes cluster"
#             title = "Kubernetes cluster manifest $[[ parameters.name ]]".replace("[[", "{{").replace("]]", "}}")
#             description: "This pull request creates the cluster-claim-$[[ parameters.name ]].yaml Kubernetes cluster manifest".replace("[[", "{{").replace("]]", "}}")
#         }
#     # }, {
#     #     id = "register"
#     #     name = "Register"
#     #     action = "catalog:register"
#     #     input = {
#     #         repoContentsUrl = "$[[ steps['publish'].output.repoContentsUrl ]]"
#     #         catalogInfoUrl = "/catalog-info.yaml"
#     #     }
#     }]
# #   output:
# #     links:
# #       - title: Repository
# #         url: ${{ steps['publish'].output.remoteUrl }}
# #       - title: Open in catalog
# #         icon: catalog
# #         entityRef: ${{ steps['register'].output.entityRef }}
# }

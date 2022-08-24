#!/bin/bash

source ./security-flag.txt >/dev/null 2>&1 || true

# echo "$@"

helm template \
  --set globalEnv.imageTag=${GITVERSION_FULLSEMVER:-testFullSemVer}-${CI_COMMIT_SHORT_SHA:-testSha} \
  --set globalEnv.version=${GITVERSION_FULLSEMVER:-testFullSemVer} \
  --set globalEnv.env=${CI_ENVIRONMENT_NAME:-tests} \
  --set globalEnv.sha=${CI_COMMIT_SHA:-testSha} \
  --set globalEnv.ci_pipeline_id="${CI_PIPELINE_ID:-testPipelineID}" \
  --set globalEnv.ci_commit_ref_name="${CI_COMMIT_REF_NAME:-testBranchName}" \
  --set globalEnv.ci_project_name="${CI_PROJECT_NAME:-testProjectName}" \
  --set globalEnv.ci_project_path="${CI_PROJECT_NAMESPACE:-testProjectPath}" \
  --set globalEnv.ci_helm_template_version=${DEPLOY_HELM_TEMPLATE_VERSION:-testHelmTemplatesVersion} \
  --set globalEnv.projectPathSlug=${CI_PROJECT_PATH_SLUG:-testProjectPathSlug} \
  --set configmap.UI_VERSION=${GITVERSION_FULLSEMVER:-testFullSemVer} \
  --set globalEnv.security_check="${SECURITY_CHECK:-skip}" \
  "$@"
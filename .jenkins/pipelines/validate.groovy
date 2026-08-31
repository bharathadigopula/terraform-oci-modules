//==============================================================================
// TERRAFORM MODULE VALIDATION
//==============================================================================

@Library('jenkins-pipeline-templates@v1.3.0') _

repositoryValidationPipeline(
    terraformDirectories: [
        'bastion',
        'budget-alert',
        'cloudflare-access-tunnel',
        'compute-instance',
        'core-network-security-group',
        'core-network-security-group-security-rule',
        'core-security-list',
        'core-subnet',
        'identity-compartment',
        'identity-dynamic-group',
        'identity-policy',
        'kms-key',
        'kms-vault',
        'mysql-db-system',
        'object-storage-bucket',
        'random-password',
        'vault-secret',
        'vcn'
    ],
    validateWorkflows: true
)
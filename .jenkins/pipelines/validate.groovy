//==============================================================================
// TERRAFORM MODULE VALIDATION
//==============================================================================

@Library('jenkins-pipeline-templates@v1.4.0') _

repositoryValidationPipeline(
    githubRepository: 'bharathadigopula/terraform-oci-modules',
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
        'identity-customer-secret-key',
        'identity-dynamic-group',
        'identity-group',
        'identity-policy',
        'identity-user',
        'identity-user-group-membership',
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